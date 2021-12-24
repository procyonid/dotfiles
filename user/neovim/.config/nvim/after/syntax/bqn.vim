syntax match bqnComment "#.*$" contains=@Spell
syntax match bqnChar "'.'"
syntax region bqnString start=+"+ end=+"+ contains=@Spell
syntax match bqnNumber "¯\?\d\(\d\|_\)*\(\.\d\(\d\|_\)*\)\?"
syntax match bqnConstant "∞\|π\|@"
syntax match bqnSystem "•[a-zA-Z]\+"
syntax match bqnFunction "+\|-\|×\|÷\|⋆\|√\|⌊\|⌈\|∧\|∨\|¬\||\|≤\|<\|>\|≥\|=\|≠\|≡\|≢\|⊣\|⊢\|⥊\|∾\|≍\|⋈\|↑\|↓\|↕\|»\|«\|⌽\|⍉\|/\|⍋\|⍒\|⊏\|⊑\|⊐\|⊒\|∊\|⍷\|⊏\|!"
syntax match bqn1Modifier "˙\|˜\|˘\|¨\|⌜\|⁼\|´\|˝\|`"
syntax match bqn2Modifier "∘\|○\|⊸\|⟜\|⌾\|⊘\|◶\|⎊\|⎉\|⚇\|⍟"
syntax match bqnSpecialName "𝕨\|𝕎\|𝕩\|𝕏\|𝕗\|𝔽\|𝕘\|𝔾\|𝕤\|𝕊"
syntax match bqnPunctuation "←\|⇐\|↩\|(\|)\|{\|}\|⟨\|⟩\|‿\|⋄\|,"

hi def link bqnComment      Comment
hi def link bqnChar         String
hi def link bqnString       String
hi def link bqnNumber       Number
hi def link bqnConstant     Constant
hi def link bqnSystem       Function
hi def link bqnFunction     Operator
" hi def link bqn1Modifier    
" hi def link bqn2Modifier
hi def link bqnSpecialName  Special
" hi def link bqnPunctuation  
