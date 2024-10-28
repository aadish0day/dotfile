# Load Autoconfig - Use True to load settings from the autoconfig.yaml file created by :set
config.load_autoconfig(False)

### 1. Appearance and Theme ###

# Enable dark mode for webpages and set the preferred color scheme to dark.
config.set("colors.webpage.darkmode.enabled", True)
config.set("colors.webpage.preferred_color_scheme", "dark")

# Set the default font size and zoom level for improved readability.
c.fonts.default_size = "10pt"
c.zoom.default = "100%"

# Always show the status bar and tabs if multiple are open.
c.statusbar.show = "always"
c.tabs.show = "multiple"

# Customize colors for a dark theme.
c.colors.statusbar.normal.bg = "#282a36"
c.colors.statusbar.normal.fg = "#f8f8f2"
c.colors.tabs.selected.even.bg = "#44475a"
c.colors.tabs.selected.odd.bg = "#44475a"
c.colors.tabs.even.bg = "#282a36"
c.colors.tabs.odd.bg = "#282a36"
c.colors.tabs.selected.even.fg = "#f8f8f2"
c.colors.tabs.selected.odd.fg = "#f8f8f2"

### 2. Privacy and Security ###

# Block third-party cookies and disable geolocation for increased privacy.
c.content.cookies.accept = "no-3rdparty"
c.content.geolocation = False
c.content.headers.referer = (
    "same-domain"  # Only send referer headers to same-domain requests
)
c.content.blocking.method = "adblock"  # Enable adblocker

# Block pages with certificate errors and change user agent to a Chrome-like one for compatibility.
config.set("content.tls.certificate_errors", "block")
c.content.headers.user_agent = (
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
    "(KHTML, like Gecko) Chrome/99 Safari/537.36"
)

# Enhanced Adblock lists with more options for privacy and social media blocking
c.content.blocking.adblock.lists = [
    "https://easylist.to/easylist/easylist.txt",  # General ad-blocking list
    "https://easylist.to/easylist/easyprivacy.txt",  # Tracker blocking list
    "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt",  # Cookie notice blocking
    "https://www.i-dont-care-about-cookies.eu/abp/",  # Extra cookie notice blocking
    "https://secure.fanboy.co.nz/fanboy-social.txt",  # Social media element blocking
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt",  # General uBlock filter
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/privacy.txt",  # Enhanced privacy blocking
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badware.txt",  # Badware and malware blocking
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/annoyances.txt",  # Blocks annoyances and pop-ups
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/legacy.txt",  # Legacy ad-blocking elements
]

### 3. Performance Tweaks ###

# Enable hardware acceleration and GPU rasterization for better performance.
c.qt.highdpi = True
c.qt.args = ["force-dark-mode", "enable-gpu-rasterization"]

# Disable autoplaying media and enable smooth scrolling.
c.content.autoplay = False
c.scrolling.smooth = True
c.tabs.background = True  # Open tabs in the background

### 4. Downloads ###

# Set default download location and remove finished downloads after 5 seconds.
c.downloads.location.directory = "~/Downloads"
c.downloads.location.prompt = False
c.downloads.remove_finished = 5000

### 5. Custom Keybindings ###

# Customize keybindings for improved tab navigation and toggling UI elements.
config.bind("J", "tab-prev")  # Previous tab
config.bind("K", "tab-next")  # Next tab

# Toggle status bar and tab bar visibility.
config.bind("xb", "config-cycle statusbar.show always never")
config.bind("xt", "config-cycle tabs.show always never")

# Keybindings for quick downloads, video viewing, and cookie toggling.
config.bind(",m", "spawn mpv {url}")
config.bind(",d", "download")
config.bind("xx", "config-cycle content.cookies.accept no-3rdparty all")

# Additional keybindings for copying and yanking URLs or text.
config.bind("yy", "yank selection")
config.bind("yt", "yank inline")

### 6. Custom Search Engines ###

# Set up custom search engines for quick access using short commands.
c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com/?q={}",
    "g": "https://www.google.com/search?q={}",
    "w": "https://en.wikipedia.org/wiki/{}",
    "yt": "https://www.youtube.com/results?search_query={}",
    "gh": "https://github.com/search?q={}",
    "rd": "https://www.reddit.com/search/?q={}",
}

# Configure start and default pages for new tabs and start-up.
c.url.start_pages = ["https://start.duckduckgo.com"]
c.url.default_page = "https://start.duckduckgo.com"

### 7. Plugins and Scripting ###

# Example plugin integration for Bitwarden (if installed as a userscript).
config.bind(",p", "spawn --userscript ~/.config/qutebrowser/userscripts/qute-bitwarden")

### 8. Auto Commands ###

# Automatically enable dark mode on pages with image handling in dark mode.
config.set("colors.webpage.darkmode.policy.images", "smart")
config.set("colors.webpage.darkmode.policy.page", "smart")

# Example PDF handling: open PDFs with zathura.
config.bind(",pdf", "spawn --detach zathura {download}")

### Final Steps ###

# Uncomment below if you want to enable smooth scrolling on specific pages
# (useful if some sites behave oddly).
# config.set("scrolling.smooth", True, "https://www.example.com")
