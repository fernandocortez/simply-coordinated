#lang racket
(require racket/gui)
(require racket/draw)

(define frame
  (new frame%
       (label "Simply Coordinated")
       (min-width 400)
       (min-height 400)))

(define menu-bar
  (new menu-bar%
       (parent frame)))

(define file-menu
  (new menu%
       (label "&File")
       (parent menu-bar)))

(define new-canvas
  (new menu-item%
       (label "&New")
       (parent file-menu)
       (callback (lambda (menu event)
                   (void)))))

(define export-canvas
  (new menu-item%
       (label "&Export")
       (parent file-menu)
       (callback (lambda (menu event)
                   (void)))))

(define help-menu
  (new menu%
       (label "&Help")
       (parent menu-bar)))

(define about
  (new menu-item%
       (label "&About")
       (parent help-menu)
       (callback (lambda (menu event)
                   (define about-dialog
                     (new dialog%
                          (label "About")))
                   
                   (define about-panel
                     (new vertical-panel%
                          (parent about-dialog)
                          (vert-margin 10)
                          (horiz-margin 10)
                          (alignment '(center center))))
                   
                   (new message%
                        (label "The purpose of this application is to teach how \n coordinate systems can be used to draw shapes")
                        (font (make-font #:size 14 #:family 'roman))
                        (parent about-panel)
                        (auto-resize #t))
                   
                   (send about-dialog show #t)))))

(define editor-panel
  (new vertical-panel%
       (parent frame)
       (vert-margin 10)
       (horiz-margin 10)
       (spacing 10)))

(define editor-controls
  (new tab-panel%
       (parent editor-panel)
       (stretchable-height #f)
       (choices (list "&Shapes "
                      "&Text "))
       (callback (lambda (tab-panel event)
                   (void)))))

(define canvas
  (new canvas%
       (parent editor-panel)))

(send frame show #t)
