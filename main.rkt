#lang racket
(require racket/gui)
(require racket/draw)

(define frame
  (new frame%
       (label "Simply Coordinated")
       ; Resizing frame resizes canvas which removes drawn objects
       (stretchable-width #f)
       (stretchable-height #f)))

(define menu-bar
  (new menu-bar%
       (parent frame)))

(define file-menu
  (new menu%
       (label "&File")
       (parent menu-bar)))

(define clear-canvas
  (new menu-item%
       (label "&Clear")
       (parent file-menu)
       (callback (lambda (menu event)
                   (send dc clear)))))

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
       (choices (list "&Rectangle"
                      "&Ellipse"
                      "&Line"))
       (callback (lambda (tab-panel event)
                   (define current-tab
                     (send editor-controls get-selection))
                   
                   (cond
                     ((= current-tab 0)
                      (send editor-controls change-children
                            (lambda (children)
                              (list rectangle-controls))))
                     ((= current-tab 1)
                      (send editor-controls change-children
                            (lambda (children)
                              (list ellipse-controls))))
                     (else
                      (send editor-controls change-children
                            (lambda (children)
                              (list line-controls)))))))))

(define rectangle-controls
  (new vertical-panel%
       (parent editor-controls)))

(define rectangle-controls-row1
  (new horizontal-panel%
       (parent rectangle-controls)
       (spacing 5)
       (vert-margin 5)
       (horiz-margin 5)))

(define rectangleX
  (new text-field%
       (parent rectangle-controls-row1)
       (label "X")
       (style '(single))))

(define rectangleY
  (new text-field%
       (parent rectangle-controls-row1)
       (label "Y")
       (style '(single))))

(define rectangle-width
  (new text-field%
       (parent rectangle-controls-row1)
       (label "Width")
       (style '(single))))

(define rectangle-height
  (new text-field%
       (parent rectangle-controls-row1)
       (label "Height")
       (style '(single))))

(new button%
     (parent rectangle-controls-row1)
     (label "Draw")
     (callback (lambda (button event)
                 (send dc set-pen
                       (send rectangle-stroke-color get-string-selection)
                       (string->number (send rectangle-stroke-width get-value))
                       'solid)
                 
                 (send dc set-brush
                       (send rectangle-fill-color get-string-selection)
                       'solid)
                 
                 (send dc draw-rectangle
                       (string->number (send rectangleX get-value))
                       (string->number (send rectangleY get-value))
                       (string->number (send rectangle-width get-value))
                       (string->number (send rectangle-height get-value))))))

(define rectangle-controls-row2
  (new horizontal-panel%
       (parent rectangle-controls)
       (spacing 5)
       (vert-margin 5)
       (horiz-margin 5)))

(define rectangle-stroke
  (new group-box-panel%
       (label "Stroke")
       (parent rectangle-controls-row2)
       (alignment '(left top))))

(define rectangle-stroke-color
  (new choice%
       (label "Color")
       (choices (list "Green"
                      "Red"
                      "Blue"
                      "White"
                      "Black"
                      "Yellow"
                      "Gray"
                      "Purple"))
       (parent rectangle-stroke)))

(define rectangle-stroke-width
  (new text-field%
       (parent rectangle-stroke)
       (label "Width")
       (style '(single))
       (init-value "1")))

(define rectangle-fill
  (new group-box-panel%
       (label "Fill")
       (parent rectangle-controls-row2)))

(define rectangle-fill-color
  (new choice%
       (label "Color")
       (choices (list "Green"
                      "Red"
                      "Blue"
                      "White"
                      "Black"
                      "Yellow"
                      "Gray"
                      "Purple"))
       (parent rectangle-fill)))

(define ellipse-controls
  (new vertical-panel%
       (parent editor-controls)
       (style '(deleted))))

(define ellipse-controls-row1
  (new horizontal-panel%
       (parent ellipse-controls)
       (spacing 5)
       (vert-margin 5)
       (horiz-margin 5)))

(define ellipseX
  (new text-field%
       (parent ellipse-controls-row1)
       (label "X")
       (style '(single))))

(define ellipseY
  (new text-field%
       (parent ellipse-controls-row1)
       (label "Y")
       (style '(single))))

(define ellipse-width
  (new text-field%
       (parent ellipse-controls-row1)
       (label "Width")
       (style '(single))))

(define ellipse-height
  (new text-field%
       (parent ellipse-controls-row1)
       (label "Height")
       (style '(single))))

(new button%
     (parent ellipse-controls-row1)
     (label "Draw")
     (callback (lambda (button event)
                 (send dc set-pen
                       (send ellipse-stroke-color get-string-selection)
                       (string->number (send ellipse-stroke-width get-value))
                       'solid)
                 
                 (send dc set-brush
                       (send ellipse-fill-color get-string-selection)
                       'solid)
                 
                 (send dc draw-ellipse
                       (string->number (send ellipseX get-value))
                       (string->number (send ellipseY get-value))
                       (string->number (send ellipse-width get-value))
                       (string->number (send ellipse-height get-value))))))

(define ellipse-controls-row2
  (new horizontal-panel%
       (parent ellipse-controls)
       (spacing 5)
       (vert-margin 5)
       (horiz-margin 5)))

(define ellipse-stroke
  (new group-box-panel%
       (label "Stroke")
       (parent ellipse-controls-row2)
       (alignment '(left top))))

(define ellipse-stroke-color
  (new choice%
       (label "Color")
       (choices (list "Green"
                      "Red"
                      "Blue"
                      "White"
                      "Black"
                      "Yellow"
                      "Gray"
                      "Purple"))
       (parent ellipse-stroke)))

(define ellipse-stroke-width
  (new text-field%
       (parent ellipse-stroke)
       (label "Width")
       (style '(single))
       (init-value "1")))

(define ellipse-fill
  (new group-box-panel%
       (label "Fill")
       (parent ellipse-controls-row2)))

(define ellipse-fill-color
  (new choice%
       (label "Color")
       (choices (list "Green"
                      "Red"
                      "Blue"
                      "White"
                      "Black"
                      "Yellow"
                      "Gray"
                      "Purple"))
       (parent ellipse-fill)))

(define line-controls
  (new vertical-panel%
       (parent editor-controls)
       (style '(deleted))))

(define line-controls-row1
  (new horizontal-panel%
       (parent line-controls)
       (spacing 5)
       (vert-margin 5)
       (horiz-margin 5)))

(define lineX1
  (new text-field%
       (parent line-controls-row1)
       (label "X1")
       (style '(single))))

(define lineY1
  (new text-field%
       (parent line-controls-row1)
       (label "Y1")
       (style '(single))))

(define lineX2
  (new text-field%
       (parent line-controls-row1)
       (label "X2")
       (style '(single))))

(define lineY2
  (new text-field%
       (parent line-controls-row1)
       (label "Y2")
       (style '(single))))

(new button%
     (parent line-controls-row1)
     (label "Draw")
     (callback (lambda (button event)
                 (send dc set-pen
                       (send line-stroke-color get-string-selection)
                       (string->number (send line-stroke-width get-value))
                       'solid)
                 
                 (send dc draw-line
                       (string->number (send lineX1 get-value))
                       (string->number (send lineY1 get-value))
                       (string->number (send lineX2 get-value))
                       (string->number (send lineY2 get-value))))))

(define line-controls-row2
  (new horizontal-panel%
       (parent line-controls)
       (spacing 5)
       (vert-margin 5)
       (horiz-margin 5)))

(define line-stroke
  (new group-box-panel%
       (label "Stroke")
       (parent line-controls-row2)
       (alignment '(left top))))

(define line-stroke-color
  (new choice%
       (label "Color")
       (choices (list "Green"
                      "Red"
                      "Blue"
                      "White"
                      "Black"
                      "Yellow"
                      "Gray"
                      "Purple"))
       (parent line-stroke)))

(define line-stroke-width
  (new text-field%
       (parent line-stroke)
       (label "Width")
       (style '(single))
       (init-value "1")))

(define canvas
  (new canvas%
       (parent editor-panel)
       (min-width 700)
       (min-height 400)))

(define dc
  (send canvas get-dc))

(send frame show #t)
