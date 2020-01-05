import os
import stat

class ThemeSetter(object):

    def __init__(self):
        self.home = os.environ["HOME"]
        self.dotfiles_dir = self.home + "/dotfiles"
        self.themes_dir = self.dotfiles_dir + "/themes"

        self.polybar_dir = self.dotfiles_dir + "/polybar"
        self.rofi_dir = self.dotfiles_dir + "/rofi"
        self.nvim_dir = self.dotfiles_dir + "/nvim"
        self.alacritty_dir = self.dotfiles_dir + "/alacritty"
        self.i3_dir = self.dotfiles_dir + "/i3"
        self.scripts_dir = self.dotfiles_dir + "/scripts"
        self.wallpaper_output = self.scripts_dir + "/fehbg"
        self.firefox_dir = self.dotfiles_dir + "/firefox"

        self.polybar_output = self.polybar_dir + "/config"
        self.rofi_output = self.rofi_dir + "/config"
        self.nvim_output = self.nvim_dir + "/theme.vim"
        self.alacritty_output = self.alacritty_dir + "/alacritty.yml"
        self.i3_output = self.i3_dir + "/config"
        self.chrome_firefox_output = self.firefox_dir + "/userChrome.css"
        self.content_firefox_output = self.firefox_dir + "/userContent.css"

    def _combine_files(self, input_filename_list, output_file_name): 
        input_files = []
        for filename in input_filename_list:
            input_files.append(open(filename))

        with open(output_file_name, mode="w", newline="") as f:
            for input_file in input_files:
                for line in input_file:
                    print(line, file=f, end="")

        for input_file in input_files:
            input_file.close()

    def _replace_in_file(self, replace_dict, input_filename, output_filename):
        input_file = open(input_filename)

        with open(output_filename, mode="w", newline="") as f:
            for line in input_file:
                if line.strip() in replace_dict.keys():
                    print(replace_dict[line.strip()], file=f, end="")
                else:
                    print(line, file=f, end="")

        input_file.close()

    def generate_firefox_css(self):
        try:
            # generate userChrome.css
            chrome_template = self.firefox_inputs["chrome_template"]        
            chrome_colors = self.firefox_inputs["chrome_colors"]
            chrome_colors_file = open(chrome_colors)
            chrome_colors_text = chrome_colors_file.read()
            chrome_colors_file.close()
            chrome_replace_dict = {
                "/* REPLACE COLORS HERE */": chrome_colors_text
            }
            chrome_output_filename = self.chrome_firefox_output
            self._replace_in_file(chrome_replace_dict, chrome_template,
                chrome_output_filename)

            # generate userContent.css
            content_template = self.firefox_inputs["content_template"]        
            content_colors = self.firefox_inputs["content_colors"]
            content_colors_file = open(content_colors)
            content_colors_text = content_colors_file.read()
            content_colors_file.close()
            content_replace_dict = {
                "/* REPLACE BACKGROUND COLOR HERE */": content_colors_text
            }
            content_output_filename = self.content_firefox_output
            self._replace_in_file(content_replace_dict, content_template,
                content_output_filename)
        except AttributeError as err:
            raise AttributeError("Failed to specify firefox file locations " +
                err)

    def generate_polybar_config(self):
        try:
            self._combine_files(self.polybar_inputs, self.polybar_output)
        except AttributeError:
            raise AttributeError("Failed to specify polybar theme files")

    def generate_nvim_config(self):
        try:
            self._combine_files(self.nvim_inputs, self.nvim_output)
        except AttributeError:
            raise AttributeError("Failed to specify neovim theme files")
        
    def generate_rofi_config(self):
        try:
            self._combine_files(self.rofi_inputs, self.rofi_output)
        except AttributeError:
            raise AttributeError("Failed to specify rofi theme files")

    def generate_alacritty_config(self):
        try:
            self._combine_files(self.alacritty_inputs, self.alacritty_output)
        except AttributeError:
            raise AttributeError("Failed to specify alacritty theme files")

    def generate_i3_config(self):
        try:
            self._combine_files(self.i3_inputs, self.i3_output)
        except AttributeError:
            raise AttributeError("Failed to specify i3 theme files")

    def set_wallpaper(self):
        try:
            self._combine_files(self.wallpaper_inputs, self.wallpaper_output)
        except AttributeError:
            raise AttributeError("Failed to specify i3 theme files")

    def set_theme(self):
        print("Generating polybar config")
        self.generate_polybar_config()
        print("Generating neovim config")
        self.generate_nvim_config()
        print("Generating rofi config")
        self.generate_rofi_config()
        print("Generating alacritty config")
        self.generate_alacritty_config()
        print("Generating i3 config")
        self.generate_i3_config()
        print("Generating firefox css")
        self.generate_firefox_css()

        print("Finished generating config files")
        print("")

        print("Setting Wallpaper")
        self.set_wallpaper()
        os.chmod(self.wallpaper_output,
            stat.S_IRUSR | stat.S_IWUSR | stat.S_IXUSR)
        os.system(self.wallpaper_output)
        print("")

        print("Restarting i3")
        _ = os.system("i3-msg restart")
        print("")

        print("Pressing hotkey to resset current nvim window")
        os.system("xdotool key --clearmodifiers Alt+r")

    
