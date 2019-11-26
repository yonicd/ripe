library(magick)
library(bunny)

x <- magick::image_read("input/pipe2.png")
y <- magick::image_read("input/replay.png")

x%>% magick::image_scale("200x200")
y%>% magick::image_scale("200x200")

hex_canvas <- image_canvas_hex(border_color="#0d4448", border_size = 2, fill_color = "#ede6f2")
hex_border <- image_canvas_hexborder(border_size = 1)

img_hex <- hex_canvas %>%
  bunny::image_compose(y%>%magick::image_scale('1300x1300'),
                       gravity = "center", offset = '+0-50')%>%  
  magick::image_annotate("%>%", size=250, weight = 700, gravity = "center", location = '-380+125', degrees = 345, font = "Fira Code")%>%
  magick::image_annotate("{ripe}", size=200, gravity = "south", location = '+400+250', degrees = 330, font = "Fira Code")%>%
  #magick::image_annotate("{ripe}", size=200, gravity = "center", location = '+75-50', degrees = 45, font = "Fira Code")%>%
  bunny::image_compose(hex_border, gravity = "center", operator = "Over")

img_hex%>%
  magick::image_scale("200x200") %>%
  magick::image_write(here::here("input", "logo.png"), density = 600)

img_hex%>%
  magick::image_scale("1200x1200") %>%
  magick::image_write(here::here("input", "hex.png"), density = 600)


img_hex_gh <- img_hex %>%
  image_scale("400x400")

gh_logo <- bunny::github %>%
  image_scale("50x50")

gh <- image_canvas_ghcard("#ffffff") %>%
  image_compose(img_hex_gh, gravity = "East", offset = "+20+0") %>%
  image_annotate("Rerun Magrittr Pipelines", gravity = "West", location = "+50-30",
                 color="#0d4448", size=60, font="Aller", weight = 700) %>%
  image_compose(gh_logo, gravity="West", offset = "+50+40") %>%
  image_annotate("yonicd/ripe", gravity="West", location="+110+45",
                 size=50, font="Ubuntu Mono") %>%
  image_border_ghcard("#ede6f2")

gh %>%
  image_write(here::here("input", "ripe_ghcard.png"))
