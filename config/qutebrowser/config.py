import nord

# don't load autoconfig
config.load_autoconfig(False)

# darkmode webpages look kinda bad...
# config.set("colors.webpage.darkmode.enabled", True)

# nord theme
nord.setup(c)

# idk... Google is still better
c.url.start_pages = ["https://google.com"]

# search engines
c.url.searchengines = {
    "DEFAULT": "https://google.com/search?hl=en&q={}",
    "gh": "https://github.com/search?o=desc&q={}&s=stars",
    "gi": "https://www.google.com/search?tbm=isch&q={}&tbs=imgo:1",
    "m": "https://www.google.com/maps/search/{}",
    "r": "https://www.reddit.com/search?q={}",
    "w": "https://en.wikipedia.org/wiki/{}",
    "yt": "https://www.youtube.com/results?search_query={}",
    "hoogle": "https://hoogle.haskell.org/?hoogle={}",
    "nixpkgs": "https://search.nixos.org/packages?sort=relevance&type=packages&query={}",
}
