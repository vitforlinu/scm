;Modernized with ModernizeMatic8 for Gimp 2.10.28 by vitforlinux.wordpress.com - dont remove

; Fix code for gimp 2.99.6 working in 2.10
(cond ((not (defined? 'gimp-drawable-get-width)) (define gimp-drawable-get-width gimp-drawable-width)))
(cond ((not (defined? 'gimp-drawable-get-height)) (define gimp-drawable-get-height gimp-drawable-height)))
(cond ((not (defined? 'gimp-text-fontname)) (define (gimp-text-fontname fn1 fn2 fn3 fn4 fn5 fn6 fn7 fn8 PIXELS fn9) (gimp-text-font fn1 fn2 fn3 fn4 fn5 fn6 fn7 fn8 fn9))))
; Fix code for gimp 2.10 working in 2.99.16
(cond ((not (defined? 'gimp-image-set-active-layer)) (define (gimp-image-set-active-layer image drawable) (gimp-image-set-selected-layers image 1 (vector drawable)))))


;;mhbevel3d
;Kiki
;http://kikidide.yuki-mura.net/GIMP/gimp.htm
;http://kikidide.yuki-mura.net/GIMP/engimp.htm
;

(define (script-fu-mhbevel2993d text size font justification buffer 3d md foption tcolor text-gradient pat
	 bg-md bg-color bggrad bgpat stp bmpblr bmpmp ck? white?)
  (let* ((img (car (gimp-image-new 256 256 RGB)))
;;文字
	 (text-layer (car (gimp-text-fontname img -1 0 0 text (* (+ (/ size 12) 4) buffer) TRUE size PIXELS font)))
;;幅と高さ
	 (width (car (gimp-drawable-get-width text-layer)))
	 (height (car (gimp-drawable-get-height text-layer)))
	 	  		  (justification (cond ((= justification 0) 2)
						       ((= justification 1) 0)
						       ((= justification 2) 1)
						       ((= justification 3) 3)))	

         (old-fg (car (gimp-context-get-foreground)))
         (old-grad (car (gimp-context-get-gradient)))
         (old-pat (car (gimp-context-get-pattern)))

)
    (gimp-image-undo-disable img)
    	     (gimp-context-push)
		(gimp-context-set-paint-mode LAYER-MODE-NORMAL-LEGACY )
    (gimp-text-layer-set-justification text-layer justification)

;;サイズ調整
    (if (= md 0) (gimp-image-resize img (+ width (* 3d stp)) (+ height (* 3d stp)) (* 3d stp) (* 3d stp)))	;rb-slant
    (if (= md 1) (gimp-image-resize img width (+ height (* (* 3d stp) 2)) 0 (* (* 3d stp) 2)))		;b-vertical
    (if (= md 2) (gimp-image-resize img (+ width (* 3d stp)) (+ height (* 3d stp)) 0 (* 3d stp)))	;lb-slant
    (if (= md 3) (gimp-image-resize img (+ width (* (* 3d stp) 2)) height 0 0))				;l-horizontal
    (if (= md 4) (gimp-image-resize img (+ width (* 3d stp)) (+ height (* 3d stp)) 0 0))		;lt-slant
    (if (= md 5) (gimp-image-resize img width (+ height (* (* 3d stp) 2)) 0 0))				;t-vertical
    (if (= md 6) (gimp-image-resize img (+ width (* 3d stp)) (+ height (* 3d stp)) (* 3d stp) 0))	;rt-slant
    (if (= md 7) (gimp-image-resize img (+ width (* (* 3d stp) 2)) height (* (* 3d stp) 2) 0))		;r-horizontal

;これがなければバンプマップが正しく適用されない
    (if (= md 0) (gimp-layer-resize text-layer (+ width (* 3d stp)) (+ height (* 3d stp)) (* 3d stp) (* 3d stp)))	;rb-slant
    (if (= md 1) (gimp-layer-resize text-layer width (+ height (* (* 3d stp) 2)) 0 (* (* 3d stp) 2)))		;b-vertical
    (if (= md 2) (gimp-layer-resize text-layer (+ width (* 3d stp)) (+ height (* 3d stp)) 0 (* 3d stp)))	;lb-slant
    (if (= md 3) (gimp-layer-resize text-layer (+ width (* (* 3d stp) 2)) height 0 0))				;l-horizontal
    (if (= md 4) (gimp-layer-resize text-layer (+ width (* 3d stp)) (+ height (* 3d stp)) 0 0))			;lt-slant
    (if (= md 5) (gimp-layer-resize text-layer width (+ height (* (* 3d stp) 2)) 0 0))				;t-vertical
    (if (= md 6) (gimp-layer-resize text-layer (+ width (* 3d stp)) (+ height (* 3d stp)) (* 3d stp) 0))	;rt-slant
    (if (= md 7) (gimp-layer-resize text-layer (+ width (* (* 3d stp) 2)) height (* (* 3d stp) 2) 0))		;r-horizontal

;前景色の設定
  (gimp-context-set-foreground tcolor)
  (gimp-layer-set-lock-alpha text-layer TRUE)
  (gimp-drawable-edit-fill text-layer FILL-FOREGROUND)
  (cond((= foption 1)
    (gimp-context-set-gradient text-gradient)
    (gimp-layer-set-lock-alpha text-layer TRUE)
;    (if (= 0 gradmd) (gimp-edit-blend text-layer BLEND-CUSTOM LAYER-MODE-NORMAL-LEGACY 0 100 20 1 FALSE FALSE 0 0 FALSE 0 0 width height))
;    (if (= 1 gradmd) (gimp-edit-blend text-layer BLEND-CUSTOM LAYER-MODE-NORMAL-LEGACY 0 100 20 1 FALSE FALSE 0 0 FALSE 0 0 width 0))
;    (if (= 2 gradmd) (gimp-edit-blend text-layer BLEND-CUSTOM LAYER-MODE-NORMAL-LEGACY 0 100 20 1 FALSE FALSE 0 0 FALSE 0 0 0 height))
    ; (gimp-edit-blend text-layer BLEND-CUSTOM LAYER-MODE-NORMAL-LEGACY 0 100 20 1 FALSE FALSE 0 0 FALSE 0 0 width height)
    (gimp-drawable-edit-gradient-fill text-layer LAYER-MODE-NORMAL-LEGACY  0 REPEAT-NONE 1 0.2 TRUE 0 0 width height)
    )
    ((= foption 2)
       (gimp-image-select-item img 2 text-layer)
       (gimp-context-set-pattern pat)
       ;(gimp-drawable-edit-bucket-fill text-layer FILL-PATTERN  100 255 )
       	(gimp-drawable-edit-fill text-layer FILL-PATTERN)
       (gimp-selection-none img)
       ))

    (script-fu-mhbevel2993dimg img text-layer TRUE 3d md bg-md bg-color bggrad bgpat stp bmpblr bmpmp ck? white? TRUE)

    (gimp-context-set-foreground old-fg)
    (gimp-context-set-gradient old-grad)
    (gimp-context-set-pattern old-pat)
    	     (gimp-context-pop)
    (gimp-image-undo-enable img)
    (gimp-display-new img)
));script-fu-mhbevel2993d

(script-fu-register "script-fu-mhbevel2993d"
		   "MH Bevel 3D LOGO 299"
		    "mhbevel2"
		    "Kiki"
		    "Kiki"
		    "2012/1"
		    ""
		    SF-TEXT     "Text String"        "3D Bevel"
		    SF-ADJUSTMENT "Font Size (pixels)" '(120 2 1000 1 10 0 1)
		    SF-FONT       "Font"               "Pump Demi Bold LET"
		SF-OPTION     _"Text Justification"    '("Centered" "Left" "Right" "Fill")
		SF-ADJUSTMENT  "Buffer"  	'(1 1 70 1 2 0 1)
		    SF-ADJUSTMENT "3D"			'(10 1 600 1 2 0 1)
                    SF-OPTION     "logo-direction"            '(_"right-bottom" _"vertical-bottom" _"left-bottom" _"left-horizontal" _"left-top" _"vertical-top" _"right-top" _"right-horizontal")
                    SF-OPTION     "fg-mode"            '(_"color" _"gradient" _"pattern")
		    SF-COLOR      "Color"              '(222 200 156)
                    SF-GRADIENT   "Gradient"           "Pastel Rainbow"
                    SF-PATTERN    "Pattern"            "Dried mud"
                    SF-OPTION     "bg-mode"            '(_"color" _"gradient" _"pattern")
		    SF-COLOR      "Background Color"   '(243 255 222)
                    SF-GRADIENT   "Background Gradient" "Greens"
                    SF-PATTERN    "Background Pattern"  "Fibers"
		    SF-ADJUSTMENT  "step"  		'(1 1 5 1 2 0 1)
		    SF-ADJUSTMENT  "bumpmap blur"  	'(5 1 70 1 2 0 1)
		    SF-ADJUSTMENT  "bumpmap depth"  	'(3 1 65 1 2 0 1)
                    SF-TOGGLE     "sp?"  		FALSE
                    SF-TOGGLE     "white?"              FALSE
)

(script-fu-menu-register "script-fu-mhbevel2993d" "<Image>/Script-Fu/Logos")

(define (script-fu-mhbevel2993dimg img drawable resize? 3d md bg-md bg-color bggrad bgpat stp bmpblr bmpmp ck? white? bg?)
  (let* (

;;幅と高さ
	 (width (car (gimp-drawable-get-width drawable)))
	 (height (car (gimp-drawable-get-height drawable)))
;;背景
	 (bg-layer (car (gimp-layer-new img width height RGB-IMAGE "Background" 100 LAYER-MODE-NORMAL-LEGACY)))
	 (bump-layer (car (gimp-layer-new img width height RGB-IMAGE "Bump" 100 LAYER-MODE-NORMAL-LEGACY)))
)
;2.4追加
  (let (
       (bcopy 0)
       (bump 0)
       (l1 0) (l2 0) (l21 0) (a 0) (b 0) (c 0) (d 0) (olda 0) (y 0)
       )
    (set! bcopy (car (gimp-layer-copy drawable 0)))
    (gimp-image-insert-layer img bcopy 0 1)
    (gimp-image-insert-layer img bump-layer 0 2)
    (gimp-context-set-foreground '(0 0 0))
    (gimp-layer-set-lock-alpha bcopy TRUE)
    (gimp-drawable-edit-fill bcopy FILL-FOREGROUND)
    (gimp-context-set-foreground '(255 255 255))
    (gimp-drawable-edit-fill bump-layer FILL-FOREGROUND)
    (set! bump (car (gimp-image-merge-down img bcopy 0)))
    (plug-in-gauss-iir2 1 img bump bmpblr bmpblr)

    (cond((= 0 md)
	(plug-in-bump-map 1 img drawable bump 135 45 bmpmp 0 0 0 0 TRUE TRUE 0)
	)
       ((= 1 md)
	(plug-in-bump-map 1 img drawable bump 135 45 bmpmp 0 0 0 0 TRUE TRUE 0)
	)
       ((= 2 md)
	(plug-in-bump-map 1 img drawable bump 45 45 bmpmp 0 0 0 0 TRUE TRUE 0)
	)
       ((= 3 md)
	(plug-in-bump-map 1 img drawable bump 45 45 bmpmp 0 0 0 0 TRUE TRUE 0)
	)
       ((= 4 md)
	(plug-in-bump-map 1 img drawable bump 225 45 bmpmp 0 0 0 0 TRUE TRUE 0)
	)
       ((= 5 md)
	(plug-in-bump-map 1 img drawable bump 225 45 bmpmp 0 0 0 0 TRUE TRUE 0)
	)
       ((= 6 md)
	(plug-in-bump-map 1 img drawable bump 225 45 bmpmp 0 0 0 0 TRUE TRUE 0)
	)
       ((= 7 md)
	(plug-in-bump-map 1 img drawable bump 135 45 bmpmp 0 0 0 0 TRUE TRUE 0)
	)
     )

    (gimp-image-remove-layer img bump)


    (cond((= 0 md)
	(set! a -1)
	(set! b 0)
	(set! c 0)
	(set! d -1)
	)
       ((= 1 md)
	(set! a 0)
	(set! b -1)
	(set! c 0)
	(set! d -1)
	)
       ((= 2 md)
	(set! a 1)
	(set! b 0)
	(set! c 0)
	(set! d -1)
	)
       ((= 3 md)
	(set! a 1)
	(set! b 0)
	(set! c 1)
	(set! d 0)
	)
       ((= 4 md)
	(set! a 1)
	(set! b 0)
	(set! c 0)
	(set! d 1)
	)
       ((= 5 md)
	(set! a 0)
	(set! b 1)
	(set! c 0)
	(set! d 1)
	)
       ((= 6 md)
	(set! a -1)
	(set! b 0)
	(set! c 0)
	(set! d 1)
	)
       ((= 7 md)
	(set! a -1)
	(set! b 0)
	(set! c -1)
	(set! d 0)
	)
     )


	(set! a (* a stp))
	(set! b (* b stp))
	(set! c (* c stp))
	(set! d (* d stp))
	(set! olda a)

    (set! y 0)
    (set! l2 (car (gimp-layer-copy drawable 0)))
    (while (< y 3d)
    (set! l1 (car (gimp-layer-copy l2 0)))     ;レイヤーのコピー作成
    (gimp-image-insert-layer img l1 0 0)                  ;レイヤー追加
    (gimp-item-transform-translate l1 a b)                    ;ずらす
    (set! l2 (car (gimp-layer-copy l1 0)))
    (gimp-image-insert-layer img l2 0 0)
    (gimp-item-transform-translate l2 c d)
    (set! y (+ y 1))

	(if (= ck? TRUE)
		(if (> y (/ 3d 2))
			(begin
			(if (= a olda) (set! a (- 0 a)))
			(cond((= 1 md)
			   (if (= 0 a)
			   (begin
				 (set! a 1)
				 (gimp-image-resize img (+ width (/ 3d 2)) height 0 0)
			    ))
			)
			((= 3 md)
			   (if (= 0 d)
			   (begin
				 (set! d 1)
				 (if (> stp 1) (set! width (+ 10 width)))
				 (gimp-image-resize img (- width (* 3d stp)) (+ height (/ 3d 2)) 0 0)
			    ))
			)
			((= 5 md)
			   (if (= 0 a)
			   (begin
				 (set! a 1)
				 (gimp-image-resize img (+ width (/ 3d 2)) height 0 0)
			    ))
			)
			((= 7 md)
			   (if (= 0 d)
			   (begin
				 (set! d 1)
				 (if (> stp 1) (set! width (+ 10 width)))
				 (if (= stp 1) (gimp-image-resize img (- width (* 3d stp)) (+ height (/ 3d 2)) (- 0 (* 3d stp)) 0))
				 (if (> stp 1) (gimp-image-resize img (- width (* 3d stp)) (+ height (/ 3d 2)) (+ (- 0 (* 3d stp)) 10) 0))
			    ))
			)
	)


			)
		)
	)

    )
    (set! l21 (car (gimp-layer-copy l2 0)))		;add
    (gimp-image-merge-visible-layers img 1)

    (gimp-image-insert-layer img l21 0 0) ;add
;    (gimp-item-transform-translate l21 -1 -1)		;add
    (if (= TRUE white?)				;add
    (begin					;add
      (gimp-context-set-foreground '(255 255 255))	;add
      (gimp-drawable-edit-fill l21 FILL-FOREGROUND)		;add
      (gimp-layer-set-opacity l21 50)		;add
    ))

;;背景色の決定
(if (= TRUE bg?)
(begin
    (gimp-context-set-foreground bg-color)
    (gimp-image-insert-layer img bg-layer 0 2)
    (gimp-layer-resize-to-image-size bg-layer)		;追加
    (gimp-drawable-fill bg-layer FILL-FOREGROUND)
    (cond((= bg-md 1)
       (gimp-context-set-gradient bggrad)
      ; (gimp-blend bg-layer BLEND-CUSTOM LAYER-MODE-NORMAL-LEGACY GRADIENT-LINEAR 100 20 REPEAT-NONE FALSE 0 0 0 0 0 0 width height)
      	(gimp-drawable-edit-gradient-fill bg-layer LAYER-MODE-NORMAL-LEGACY  0 REPEAT-NONE 1 0.2 TRUE 0 0 width height)

      )
       ((= bg-md 2)
       (gimp-selection-all img)
       (gimp-context-set-pattern bgpat)
       ;(gimp-drawable-edit-bucket-fill bg-layer FILL-PATTERN  100 255 )
       	(gimp-drawable-fill bg-layer FILL-PATTERN)
       (gimp-selection-none img)
       ))
))

;;;    (if (= TRUE fr?) (gimp-image-flatten img))

;2.4追加(let)
 )

))





;ここはTosi様のscript-fuを使用しました。
;http://www.geocities.jp/gimproject/scripts/layers-view-delete.html

(define (script-fu-layers-view-none image drawable)
 (let* ((layers (gimp-image-get-layers image))
	    (number-layers (car layers))
	    (layer-array (cadr layers))
	    (layer-count 0)
	    (layer))
    (set! layer-count 0)
    (while (< layer-count number-layers)
           (set! layer (aref layer-array layer-count))
           (gimp-item-set-visible layer FALSE)
           (set! layer-count (+ layer-count 1)))
))
(define (script-fu-layers-view-current-only image drawable)
    (script-fu-layers-view-none image drawable)
    (if (not (= 0 (car (gimp-drawable-is-layer drawable))))
        (gimp-item-set-visible drawable TRUE))
)


;こっちが本体
(define (script-fu-mhbevel2993dimg22 img2 drawable2 resize? 3d md stp bmpblr bmpmp ck? white?)
  (let* (
	(img (car (gimp-image-duplicate img2)))
	;(drawable (car (gimp-image-get-active-layer img)))
        ( drawable (car (gimp-image-get-active-layer img)))
	

;;幅と高さ
	 (width (car (gimp-drawable-get-width drawable)))
	 (height (car (gimp-drawable-get-height drawable)))
;;背景
	 (bg-layer (car (gimp-layer-new img width height RGB-IMAGE "Background" 100 LAYER-MODE-NORMAL-LEGACY)))
	 (bump-layer (car (gimp-layer-new img width height RGB-IMAGE "Bump" 100 LAYER-MODE-NORMAL-LEGACY)))

         (old-fg (car (gimp-context-get-foreground)))
         (old-grad (car (gimp-context-get-gradient)))
         (old-pat (car (gimp-context-get-pattern)))
)

    (gimp-image-undo-disable img)
        	     (gimp-context-push)
		(gimp-context-set-paint-mode LAYER-MODE-NORMAL-LEGACY )

    (script-fu-layers-view-current-only img drawable)	;Tosi様のscript-fuより

;;サイズ調整
(if (= resize? TRUE)
(begin
    (if (= md 0) (gimp-image-resize img (+ width (* 3d stp)) (+ height (* 3d stp)) (* 3d stp) (* 3d stp)))	;rb-slant
    (if (= md 1) (gimp-image-resize img width (+ height (* (* 3d stp) 2)) 0 (* (* 3d stp) 2)))		;b-vertical
    (if (= md 2) (gimp-image-resize img (+ width (* 3d stp)) (+ height (* 3d stp)) 0 (* 3d stp)))	;lb-slant
    (if (= md 3) (gimp-image-resize img (+ width (* (* 3d stp) 2)) height 0 0))				;l-horizontal
    (if (= md 4) (gimp-image-resize img (+ width (* 3d stp)) (+ height (* 3d stp)) 0 0))		;lt-slant
    (if (= md 5) (gimp-image-resize img width (+ height (* (* 3d stp) 2)) 0 0))				;t-vertical
    (if (= md 6) (gimp-image-resize img (+ width (* 3d stp)) (+ height (* 3d stp)) (* 3d stp) 0))	;rt-slant
    (if (= md 7) (gimp-image-resize img (+ width (* (* 3d stp) 2)) height (* (* 3d stp) 2) 0))		;r-horizontal

;これがなければバンプマップが正しく適用されない
    (if (= md 0) (gimp-layer-resize drawable (+ width (* 3d stp)) (+ height (* 3d stp)) (* 3d stp) (* 3d stp)))	;rb-slant
    (if (= md 1) (gimp-layer-resize drawable width (+ height (* (* 3d stp) 2)) 0 (* (* 3d stp) 2)))		;b-vertical
    (if (= md 2) (gimp-layer-resize drawable (+ width (* 3d stp)) (+ height (* 3d stp)) 0 (* 3d stp)))	;lb-slant
    (if (= md 3) (gimp-layer-resize drawable (+ width (* (* 3d stp) 2)) height 0 0))				;l-horizontal
    (if (= md 4) (gimp-layer-resize drawable (+ width (* 3d stp)) (+ height (* 3d stp)) 0 0))			;lt-slant
    (if (= md 5) (gimp-layer-resize drawable width (+ height (* (* 3d stp) 2)) 0 0))				;t-vertical
    (if (= md 6) (gimp-layer-resize drawable (+ width (* 3d stp)) (+ height (* 3d stp)) (* 3d stp) 0))	;rt-slant
    (if (= md 7) (gimp-layer-resize drawable (+ width (* (* 3d stp) 2)) height (* (* 3d stp) 2) 0))		;r-horizontal
))

    (script-fu-mhbevel2993dimg img drawable resize? 3d md "color" old-fg old-grad old-pat stp bmpblr bmpmp ck? white? FALSE)

    (gimp-context-set-foreground old-fg)
    (gimp-context-set-gradient old-grad)
    (gimp-context-set-pattern old-pat)
        	     (gimp-context-pop)

    (gimp-image-undo-enable img)
    (gimp-display-new img)
))



(script-fu-register "script-fu-mhbevel2993dimg22"
		    "MH Bevel 3D 299 ALPHA"
		    "mhbevel3dimg"
		    "Kiki"
		    "Kiki"
		    "2012/1"
		    "RGBA"
		    SF-IMAGE      "Image"     0
		    SF-DRAWABLE   "Drawable"  0
                    SF-TOGGLE     "resize?"  		TRUE
		    SF-ADJUSTMENT "3D"			'(10 1 600 1 2 0 1)
                    SF-OPTION     "direction"            '(_"right-bottom" _"vertical-bottom" _"left-bottom" _"left-horizontal" 
						_"left-top" _"vertical-top" _"right-top" _"right-horizontal")
		    SF-ADJUSTMENT  "step"  		'(1 1 5 1 2 0 1)
		    SF-ADJUSTMENT  "bumpmap blur"  	'(5 1 70 1 2 0 0)
		    SF-ADJUSTMENT  "bumpmap depth"  	'(3 1 65 1 2 0 1)
                    SF-TOGGLE     "sp?"  		FALSE
                    SF-TOGGLE     "white?"              FALSE
)
(script-fu-menu-register "script-fu-mhbevel2993dimg22" "<Image>/Script-Fu/Alpha-to-Logo")
