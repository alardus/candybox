import hashlib, ConfigParser, os, crypt
from bottle import run, route, request, response, redirect, view, template, static_file

CAVA_SECRET = 'cava-hava-cacava'

if os.environ.get('DEVEL', 0) != 0:
    ETC_AUTH_FILE = 'cava-auth'

    etc_chap_secrets = 'chap-secrets'
    etc_xl2tpd_conf   = 'xl2tpd.conf'
    issues            = 'issue'
    uptime            = 'uptime'
    ifaces            = 'ifaces'
    connect           = 'connect'
    dyndns            = 'ddclient.conf'
    ddns              = 'ddns'
    ddns_status       = 'ddns_status'
    proxy             = 'dnsmasq.conf'
else:
    ETC_AUTH_FILE = '/etc/cava-auth'

    etc_chap_secrets = '/etc/ppp/chap-secrets'
    etc_xl2tpd_conf   = '/etc/xl2tpd/xl2tpd.conf'
    issues            = '/var/log/bearouter/issue'
    uptime            = '/var/log/bearouter/uptime'
    ifaces            = '/var/log/bearouter/ifaces'
    connect           = '/var/log/bearouter/connect'
    proxy             = '/etc/dnsmasq.conf'
    dyndns            = '/etc/ddclient.conf'
    ddns              = '/var/log/bearouter/ddns'
    ddns_status       = '/var/log/bearouter/ddns_status'


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

                # Change password for nothing for security reason
                password = 'enter_your_password_again'

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
    os.system('service xl2tpd restart')
    return

def get_dyn_info():
    with open(dyndns, 'r') as fl:
        lines = fl.readlines()
        login = None
        password = None
        host = None
        for line in lines:
            if "=" in line:
                key, value = line.split('=', 1)
                key = key.strip()
                if key == "login":
                    login = value.strip()
                elif key == "pasword":
                    password = value.strip()
                elif key == "host":
                    host = value.strip()
        return login, password, host


def put_dyndns(login, password, host):
    fl = open(dyndns, 'r')
    lines = fl.readlines()
    fl.close()

    fl = open(dyndns, 'w')
    for line in lines:
        if not "login" in line:
            pass
            if not "password" in line:
                pass
                if not "host" in line:
                    fl.write(line)
    fl.close()

    fl = open(dyndns, 'a')
    fl.write('login=' + login + '\n')
    fl.write('password=' + password + '\n')
    fl.write('host=' + host + '\n')
    fl.close()
    os.system('service ddclient restart')
    os.system('/usr/bin/bearouter-logs.sh')

def get_proxy_netflix():
    netflix_tunlr='142.54.177.158'
    netflix_block='208.122.23.22'
    fl = open(proxy, 'r')
    lines = fl.readlines()
    for line in lines:
        if not "netflix.com" in line:
            continue
        line = line.split('/')
        if len(line) == 3:
            [server, netflix, netflix_ip] = line
            netflix_ip = netflix_ip.strip()
            if netflix_ip==netflix_block:
                netflix_block = "selected"
            if netflix_ip==netflix_tunlr:
                netflix_tunlr = "selected"
            return netflix_block, netflix_tunlr
    fl.close()
    return None, None

def get_proxy_pandora():
    pandora_tunlr='142.54.177.158'
    pandora_block='208.122.23.22'
    fl = open(proxy, 'r')
    lines = fl.readlines()
    for line in lines:
        if not "pandora.com" in line:
            continue
        line = line.split('/')
        if len(line) == 3:
            [server, pandora, pandora_ip] = line
            pandora_ip = pandora_ip.strip()
            if pandora_ip==pandora_block:
                pandora_block = "selected"
            if pandora_ip==pandora_tunlr:
                pandora_tunlr = "selected"
            return pandora_block, pandora_tunlr
    fl.close()
    return None, None

def put_proxy(netflix, pandora):
    fl = open(proxy, 'r')
    lines = fl.readlines()
    fl.close()

    fl = open(proxy, 'w')
    for line in lines:
        if "netflix.com" not in line:
            if "pandora.com" not in line:
                fl.write(line)
    fl.close()

    fl = open(proxy, 'a')
    fl.write('server=/netflix.com/' + netflix + '\n')
    fl.write('server=/pandora.com/' + pandora + '\n')
    fl.close()
    os.system('service dnsmasq restart')

@route('/static/:path#.+#', name='static')
def static(path):
    return static_file(path, root='static')

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

        # Change user 'router' system password
        salt_pwd = crypt.crypt(pwd,"8C")
        os.system('usermod -p %s router' % salt_pwd)

        return redirect('/login')
    pwd = hashlib.md5(pwd).hexdigest()
    if auth == pwd:
        response.set_cookie('auth', pwd, secret = CAVA_SECRET)
        return redirect('/')
    else:
        return redirect('/login')

@route('/proxy', method="POST")
def index():
    auth = request.get_cookie('auth', None, secret = CAVA_SECRET)
    if not auth or auth != getAuthCachie(): return redirect('/login')

    netflix = request.forms.get('netflix')
    pandora = request.forms.get('pandora')
    put_proxy(netflix, pandora)
    return redirect('/password')

@route('/dyndns', method="POST")
def index():
    auth = request.get_cookie('auth', None, secret = CAVA_SECRET)
    if not auth or auth != getAuthCachie(): return redirect('/login')

    login = request.forms.get('login')
    password = request.forms.get('password')
    host = request.forms.get('host')
    put_dyndns(login, password, host)
    return redirect('/password')

@route('/password', method = 'POST')
def index():
    auth = request.get_cookie('auth', None, secret = CAVA_SECRET)
    if not auth or auth != getAuthCachie(): return redirect('/login')

    error = None
    login = request.forms.get('login', None)
    pwd   = request.forms.get('pwd',   None)
    put_login_pass(login, pwd)
    return redirect('/password')

@route('/password')
@route('/')
def index():
    auth = request.get_cookie('auth', None, secret = CAVA_SECRET)
    if not auth or auth != getAuthCachie(): return redirect('/login')

    login, pwd = get_login_pass()
    cnn = open(connect).read()
    cnn = cnn.strip()
    dns = open(ddns_status).read()
    dns = dns.strip()
    netflix_block, netflix_tunlr = get_proxy_netflix()
    pandora_block, pandora_tunlr = get_proxy_pandora()
    dyn_login, dyn_password, dyn_host = get_dyn_info()
    return template('password', dict(error = None, login = login, pwd = pwd, netflix_block = netflix_block, netflix_tunlr = netflix_tunlr, pandora_block = pandora_block, pandora_tunlr = pandora_tunlr, connect = cnn, dyn_login = dyn_login, dyn_password = dyn_password, dyn_host = dyn_host, dns = dns))

@route('/info')
def index():
    auth = request.get_cookie('auth', None, secret = CAVA_SECRET)
    if not auth or auth != getAuthCachie(): return redirect('/login')

    iss = open(issues).read()
    upt = open(uptime).read()
    ifs = open(ifaces).read()
    cnn = open(connect).read()
    dns = open(ddns).read()
    return template('info', dict(error = None, issues = iss, uptime = upt, ifaces = ifs, connect = cnn, dns = dns))

run(host = '0.0.0.0', port=8080, debug=True, reloader=True)
