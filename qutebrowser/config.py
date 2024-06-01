# Load autoconfig settings (if you want to include GUI-configured settings)
config.load_autoconfig()

# Start page
#c.url.start_pages = 'https://www.example.com'

# Default search engine
c.url.searchengines = {'DEFAULT': 'https://duckduckgo.com/?q={}'}

# Keybindings
config.bind('xb', 'config-cycle statusbar.show always never')
config.bind('xt', 'config-cycle tabs.show always never')

# Privacy settings
c.content.webrtc_ip_handling_policy = 'disable-non-proxied-udp'

# Enable dark mode
c.colors.webpage.darkmode.enabled = True

# Ad blocking using both hosts file and integrated ad blocker
c.content.blocking.method = 'both'

c.content.blocking.adblock.lists = [
    'https://easylist.to/easylist/easylist.txt',
    'https://easylist.to/easylist/easyprivacy.txt',
    'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt',
    'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badware.txt',
    'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/privacy.txt',
    'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/resource-abuse.txt',
    'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/unbreak.txt'
]

c.content.blocking.hosts.lists = [
    'https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts'
]


# User stylesheets
#c.content.user_stylesheets = ['~/.config/qutebrowser/css/custom.css']

# Autocompletion
c.completion.shrink = True
c.completion.web_history.max_items = 1000

