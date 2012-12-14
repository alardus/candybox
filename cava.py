import hashlib, ConfigParser, os
from bottle import run, route, request, response, redirect, view, template

CAVA_SECRET = 'cava-hava-cacava'
ETC_AUTH_FILE = '/etc/cava-auth'

etc_chap_secrets = '/etc/ppp/chap-secrets'
etc_xl2tpd_conf   = '/etc/xl2tpd/xl2tpd.conf'

#ETC_AUTH_FILE = 'cava-auth'
#etc_chap_secrets = 'chap-secrets'
#etc_xl2tpd_conf   = 'xl2tpd.conf'

def getAuthCachie():
    try:
        with open(ETC_AUTH_FILE, 'r') as fl:
            return fl.read()
    except:
        return None

def putAuthCachie(auth):
    with open(ETC_AUTH_FILE, 'w') as fl:
        fl.write(hashlib.md5(auth).hexdigest())

def get_login_pass():
    if not os.path.isfile(etc_chap_secrets):
        return None, None
    with open(etc_chap_secrets, 'r') as fl:
        for line in fl.readlines():
            line = line.strip()
            if line.startswith('#'):
                continue
            line = line.split(' ')
            if len(line) == 3:
                [username, dot, password] = line
                return username, password
    return None, None

def put_login_pass(login, pwd):
    with open(etc_chap_secrets, 'w') as fl:
        fl.write(login + ' * ' + pwd + '\n')
    sp = ConfigParser.SafeConfigParser()
    sp.read(etc_xl2tpd_conf)
    sp.set('global', 'access control', 'yes')
    sp.set('global', 'auth file', '/etc/ppp/chap-secrets')
    sp.set('lac beeline', 'lns', 'tp.internet.beeline.ru')
    sp.set('lac beeline', 'redial', 'yes')
    sp.set('lac beeline', 'redial timeout', '1')
    sp.set('lac beeline', 'require chap', 'yes')
    sp.set('lac beeline', 'require pap', 'no')
    sp.set('lac beeline', 'require authentication', 'no')
    sp.set('lac beeline', 'name', login)
    sp.set('lac beeline', 'ppp debug', 'yes')
    sp.set('lac beeline', 'pppoptfile', '/etc/ppp/options.xl2tpd')
    sp.set('lac beeline', 'autodial', 'yes')
    with open(etc_xl2tpd_conf, 'w') as fl:
        sp.write(fl)
    return



@route('/login')
def login():
    response.delete_cookie('auth')
    auth = getAuthCachie()
    return template('login', dict(isnew = (auth == None)))

@route('/login', method="POST")
def login_post():
    auth = getAuthCachie()
    pwd = request.forms.get('password', None)
    if auth == None:
        putAuthCachie(pwd)
        return redirect('/login')
    pwd = hashlib.md5(pwd).hexdigest()
    if auth == pwd:
        response.set_cookie('auth', pwd, secret = CAVA_SECRET)
        return redirect('/')
    else:
        return redirect('/login')


@route('/restart', method="GET")
def restartxl():
    os.system('service xl2tpd restart')
    return redirect('/password')

@route('/password', method = 'POST')
def index():
    auth = request.get_cookie('auth', None, secret = CAVA_SECRET)
    if not auth or auth != getAuthCachie(): return redirect('/login')

    error = None
    login = request.forms.get('login', None)
    pwd   = request.forms.get('pwd',   None)

    put_login_pass(login, pwd)

    return template('password', dict(error = error, login = login, pwd = pwd))

@route('/password')
@route('/')
def index():
    auth = request.get_cookie('auth', None, secret = CAVA_SECRET)
    if not auth or auth != getAuthCachie(): return redirect('/login')

    login, pwd = get_login_pass()

    return template('password', dict(error = None, login = login, pwd = pwd))

run(host = '0.0.0.0', port=8080, debug=True)
