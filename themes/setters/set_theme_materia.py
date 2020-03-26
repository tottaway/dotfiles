from set_theme_common import ThemeSetter

class MateriaThemeSetter(ThemeSetter):
    def __init__(self, *args, **kw):
        super().__init__(*args, **kw)
        self.theme_dir = self.themes_dir + "/materia"
        self.common_dir = self.themes_dir + "/common"
        self.polybar_inputs = [
            self.theme_dir + "/polybar_colors",
            self.common_dir + "/polybar_common"
        ]
        self.nvim_inputs = [
            self.common_dir + "/theme.vim",
            self.theme_dir + "/nvim_theme.vim"
        ]
        self.rofi_inputs = [self.theme_dir + "/rofi_config"]
        self.alacritty_inputs = [
            self.common_dir + "/common_alacritty.yml",
            self.theme_dir + "/alacritty_colors.yml"
        ]
        self.i3_inputs = [
            self.common_dir + "/i3_common",
            self.theme_dir + "/i3_theme"
        ]
        self.wallpaper_inputs = [self.theme_dir + "/fehbg"]
        self.firefox_inputs = {
            "chrome_template": self.common_dir + "/firefox_common_chrome.css",
            "chrome_colors": self.theme_dir + "/firefox_colors.css",
            "content_template": self.common_dir + "/firefox_common_content.css",
            "content_colors": self.theme_dir + "/firefox_content_colors.css"
        }

