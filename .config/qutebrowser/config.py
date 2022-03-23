# defaults
config.load_autoconfig(False)
config.set('content.cookies.accept', 'all', 'chrome-devtools://*')
config.set('content.cookies.accept', 'all', 'devtools://*')
# config.set('content.headers.accept_language', '', 'https://matchmaker.krunker.io/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}', 'https://web.whatsapp.com/')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:90.0) Gecko/20100101 Firefox/90.0', 'https://accounts.google.com/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99 Safari/537.36', 'https://*.slack.com/*')
config.set('content.images', True, 'chrome-devtools://*')
config.set('content.images', True, 'devtools://*')
config.set('content.javascript.enabled', True, 'chrome-devtools://*')
config.set('content.javascript.enabled', True, 'devtools://*')
config.set('content.javascript.enabled', True, 'chrome://*/*')
config.set('content.javascript.enabled', True, 'qute://*/*')

# colors
config.source('colors.py')
c.tabs.show = 'multiple'
c.colors.webpage.bg = 'black'
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.algorithm = 'lightness-cielab'

# settings
config.set('content.javascript.can_access_clipboard', True)
c.editor.command = ['nvim', '{file}']
c.messages.timeout = 1000

## statusbar
c.statusbar.widgets = ['url', 'scroll', 'progress']

## search engines
c.url.searchengines['gh'] = 'https://github.com/search?q={}'
c.url.searchengines['yt'] = 'https://youtube.com/search?q={}'
c.url.searchengines['go'] = 'https://google.com/search?q={}'

## downloads
c.downloads.location.directory = '~/Downloads'
c.downloads.location.prompt = False
c.downloads.position = 'bottom'
c.downloads.remove_finished = 0

## completion
c.completion.open_categories = ['quickmarks', 'history']

# keybindings
config.bind('<Meta-r>', 'config-source ;; message-info "qutebrowser reloaded"')
config.bind('<Meta-p>', 'spawn --userscript qute-pass')
config.bind('<Meta-o>', 'spawn --userscript qute-pass --password-only')

## zoom
config.bind('-', 'zoom-out')
config.bind('=', 'zoom-in')
config.bind('0', 'zoom')
config.bind('<Alt-f>', 'fullscreen')

## scrolling
config.bind('J', 'scroll-page 0 1')
config.bind('K', 'scroll-page 0 -1')

## tabs
config.bind('<Meta-j>', 'tab-prev')
config.bind('<Meta-k>', 'tab-next')
config.bind('<Meta-Left>', 'tab-move -')
config.bind('<Meta-Right>', 'tab-move +')
config.bind('x', 'tab-close')
config.bind('<Meta-n>', 'set-cmd-text -s :open -t')
config.bind('<Meta-b>', 'set-cmd-text -s :quickmark-load -t')
config.bind('<w>', 'tab-give')

## yank
config.bind('yy', 'yank --quiet url')
config.bind('yf', 'hint links yank')
config.bind('yt', 'open --related --tab {url}')
config.bind('yw', 'open --window {url}')

## history
config.bind('H', 'back')
config.bind('L', 'forward')

## hints
config.bind('i', 'hint --first inputs')
config.bind('I', 'hint inputs')
config.bind('q', 'jseval -q document.activeElement.blur()')
config.bind('<Escape>', 'mode-leave ;; jseval -q document.activeElement.blur()', mode='insert')

## marks
config.bind('M', 'set-cmd-text -s :set-mark')
config.bind('m', 'set-cmd-text -s :jump-mark')
