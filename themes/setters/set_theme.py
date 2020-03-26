from set_theme_materia import MateriaThemeSetter
from set_theme_gruvbox_dark import GruvboxDarkThemeSetter
from set_theme_gruvbox_light import GruvboxLightThemeSetter
from set_theme_solarized_light import SolarizedLightThemeSetter
import argparse

if __name__ == "__main__":
    themes = [
        "materia",
        "gruvbox",
        "solarized"
    ]
    parser = argparse.ArgumentParser(description='Set computer theme')
    parser.add_argument("theme", type=str, choices=themes)
    parser.add_argument("-l", action="store_true", help="light theme")
    args = parser.parse_args()
    if args.theme == "materia":
        if args.l:
            print("No light theme available for Materia")
        theme_setter = MateriaThemeSetter()
    elif args.theme == "gruvbox":
        if args.l:
            theme_setter = GruvboxLightThemeSetter()
        else:
            theme_setter = GruvboxDarkThemeSetter()
    elif args.theme == "solarized":
        if not args.l:
            print("Solized Dark has not been implemented, using solarized" +
                "light instead")
        theme_setter = SolarizedLightThemeSetter()
    else:
        print(args.theme + " is not supported")

    theme_setter.set_theme()
