(add-to-list 'load-path (expand-file-name "custom" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "custom/languages" user-emacs-directory))

(setq package-archives '(("melpa" . "http://melpa.milkbox.net/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")))

(require 'package)
(package-initialize)
(setq package-enable-at-startup nil)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

(require 'my-core)
(require 'my-codestyle)
(require 'my-eyecandy)
(require 'my-ido)
(require 'my-magit)
(require 'my-ag)
(require 'my-projectile)
(require 'my-flycheck)
(require 'my-ruby)
(require 'my-slim)
(require 'my-sass)
(require 'my-coffeescript)
(require 'my-evil)
