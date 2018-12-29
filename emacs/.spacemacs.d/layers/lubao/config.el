(global-linum-mode t)

(global-set-key (kbd "M-s 0") 'occur-dwim)

(evilified-state-evilify-map occur-mode-map
  :mode occur-mode)
