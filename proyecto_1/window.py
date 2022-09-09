from pathlib import Path
from tkinter import *

from PIL import ImageTk, Image


class Window:
    NAME = 'Bilinear Picker'
    WIN_SIZE = '1024x768'
    IMAGE_INPUT_CONFIG = {'width': 390, 'height': 390}
    BASE_DIR = Path(__file__).resolve().parent
    root = None
    PAD = 5

    def __init__(self):
        self.root = Tk()
        self.root.title(self.NAME)
        self.root.geometry(self.WIN_SIZE)
        self.root.resizable(False, False)

    def start(self):
        input_img_frame = LabelFrame(self.root, text="Imagen de entrada")
        input_img_frame.grid(row=0, column=0, sticky=W, padx=self.PAD, pady=self.PAD)

        in_img_preview = Canvas(input_img_frame, self.IMAGE_INPUT_CONFIG)
        image = self.BASE_DIR / 'media' / 'bacteria.jpg'
        in_img = ImageTk.PhotoImage(Image.open(image))
        in_img_preview.create_image(0, 0, anchor=NW, image=in_img)
        in_img_preview.grid(row=0, column=0, sticky=W, padx=self.PAD, pady=self.PAD)

        out_img_frame = LabelFrame(self.root, text="Imagen de salida")
        out_img_frame.grid(row=0, column=1, sticky=W, padx=self.PAD, pady=self.PAD)

        out_img_preview = Canvas(out_img_frame, self.IMAGE_INPUT_CONFIG)
        image = self.BASE_DIR / 'media' / 'bacteria.jpg'
        out_img = ImageTk.PhotoImage(Image.open(image))
        out_img_preview.create_image(0, 0, anchor=NW, image=out_img)
        out_img_preview.grid(row=0, column=1, sticky=W, padx=self.PAD, pady=self.PAD)

        self.root.mainloop()


if __name__ == '__main__':
    win = Window()
    win.start()