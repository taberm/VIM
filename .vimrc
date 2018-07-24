" vimrc
" -----
" Created on 07 Sep 2004 by Fred Damstra (fred@monkeybox.org)
"
" This is a combination of things I invented myself and things I grabbed off
" the web.  There should probably be more credit in here than there is, but oh
" well.  Do a search for "vimrc" on google, and you'll find more examples than
" you'd know what to do with.
"
" Additionally, I recomment you do the following in your homedirectory.
"   mkdir .vim
"   mkdir .vim/{bin,doc,ftplugin,plugin}
"   cp /usr/share/vim/vim63/ftplugin/* .vim/ftplugin
"   cp /usr/share/vim/vim63/macros/matchit.vim .vim/plugin
"   cp /usr/share/vim/vim63/macros/matchit.txt .vim/doc
"
" And create an executable file in .vim/bin called phpdoc that contains the
" following 2 lines:
"   #!/bin/bash
"   elinks --dump 1 http://www.php.net/$1 | less
"
" Naturally, you'll need elinks installed for that to work.
"
" Last-Updated: <27 Sep 2004 17:22:31 Fred Damstra (fdamstra@cuanswers.com)> 
" 
" Timestamps are broken, dammit.


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Section 1: Appearance
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM ships with many colorschemes.  On my system, they're found in
" $VIMRUNTIME/colors/.  The evening scheme seems to work pretty well for me:
"colorscheme evening
colorscheme industry

let myname  = "mrt"
let myemail = "matt.taber@cuanswers.com"

" Briefly flip to the matching tag whenever one is typed.
set showmatch

" Don't beep, just flash
set visualbell
set vb t_vb=

" Show cursor position all the time.
set ruler	

" Syntax highlighting is a good thing
syntax on	

" Change the minimum number of lines that vim uses to attempt syntax
" highlighting.  Note that higher numbers lessen the chance of incorrect syntax
" highlighting, but require more processing.
let c_minlines=1000

" Instead of c_minlines, you could also do this to always process the entire
" file.  This would be a big performance problem on large files:
"autocmd BufEnter * :syntax sync fromstart

" When a change is made with a : command, always show results.
set report=0            

" use [RO] for Read only.
set shortmess+=r

" Display current mode and partially typed commands in the status line
set showmode
set showcmd

" By default, don't wrap text when the text doesn't wrap.
set nowrap

" Show the best match so far as search strings are typed
set incsearch

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Section 2: System Files
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" I have no idea what all these settings are, but it generally keeps my
" .viminfo behaving like I want it to.
set viminfo=%,'50,\"100,:100,n~/.viminfo 

" Keep 50 lines of history
"set history=50
set history=200

" Generally, I don't like vim making backups.  And if it does make backups, I
" certainly don't want them cluttering the original directory.  So here's my
" happy medium.
"
" If the directory ~/.vim_backup exists, keep a backup file there.  If not, 
" don't keep any backups at all.
let BACKUPDIR=expand("~/.vim_backup")
if isdirectory(BACKUPDIR)
  set backup
  set backupdir=~/.vim_backup
else
  set nobackup	" Don't keep a backup file
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Section 2: Insert Mode Stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Here's indentation the way I like it.  Note that some of these settings are
" overridden based on filetype in the section below (such as not expanding tabs
" when editing makefiles.
set softtabstop=5	" interpret tab as an 'indent to next marker'
set shiftwidth=5	" 2-space when hitting tab
set shiftround
set expandtab		" insert spaces, not tab characters.
set autoindent

" Normally don't automatically format 'text' as it's typed.  However, I do want
" vim to automatically wrap the comments for me at 79 characters.
set formatoptions-=t
set textwidth=79


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Section 3: Vim Behavior
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Add <>'s to the % key
set matchpairs+=<:>

" Have command-line completion with <TAB>.
set wildmode=list:longest,full

" For filename completion, vim thinks "=" is a valid character.  This means
" that tab completion won't work for variables in scripts, like:
"   FILE=/usr/src/...
"
" Since it's unlikely that any of my real filenames would contain an =, 
" just remove it from the list.
set isfname-==

" Make search case-insensitive, unless it contains an uppercase letter
set ignorecase
set smartcase

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Section 4: Key Bindings and behavior
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Summary:
"   [] - open/close folds
"   Q  - Reformat current paragraph or selected text
"   :co - Comment out lines
"   :ci - Comment in lines [currently broken]
"   ;s  - Quicksave a backup file, then continue working on current file.
"   F1 - Prompts for help string
"   F6/S-F6 - Cycle through split windows
"   F8  - Add word under cursor to personal dictionary
"   F9  - Highlight spelling mistakes
"   F10 - Clear highlighted spelling mistakes
"

" Use []'s for folding, and only fold if I mark it.
set foldmethod=marker
set foldmarker={{{,}}}   " default is "{{{,}}}"
map [ zc
map ] zo 

" Let h and l move over line breaks
set whichwrap=h,l

" Have shift-arrows scroll - Appears not to work in linux
"map <S-Down> <C-E>
"map <S-Up> <C-Y>

" Use F6 to cycle through split windows, shift-f6 to cycle backwards
nnoremap <F6> <C-W>w
nnoremap <S-F6> <C-W>W

" Have F1 prompt for a help topic, rather than just opening the intro page,
" and do that from any mode.
nnoremap <F1> :help<Space>
vmap <F1> <C-C><F1>
omap <F1> <C-C><F1>
map <F1> <C-C><F1>

" Have Q reforamt the current paragraph (or selected text if any)
nnoremap Q gqap
vnoremap Q gq

" Have the usual indentation keystrokes still work in visual mode
vnoremap <C-T> >
vnoremap <C-D> <LT>
vmap <Tab> <C-T>
vmap <S-Tab> <C-D>

" Allow backspace to back up over line breaks, beyond the start of the current
" indentation, and over indentations:
set backspace=eol,start,indent

" Spelling keys.  F9 highlights, F10 clears highights
nmap <F8> \sa
nmap <F9> \sh
nmap <F10> \sc

" HTML Shortcut Keys
imap <F2> <Space><BS><Esc>\hca  " Automatically close last tag
imap <F3> <Space><BS><Esc>\hpa  " Repeat last open tag with all attributes
imap <F10> <Space><BS><Esc>\hna " Repeat next open tag with all attributes

" Enable special keymappings for html files.  Some examples are:
"   \& -> &amp;
"   \\ -> \
"   \  -> &nbsp;
"   etc.
" I've disabled this, because it causes annoying errors when switching 
" buffers.
"autocmd BufEnter * if &filetype == "html" | call MapHTMLKeys(1) | endif

" Comment out/in lines.  The Comment in function is currently broken, and any
" help would be much appreciated.
vmap co :call CommentLines()<CR>
vmap ci :call UnCommentLines()<CR>

" QuickSaveBackup with Datestamp, using the keystrokes ';s'... Note that
" this only saves thefilename with year-month-day... If you want more detail,
" change the strftime to add hours, minutes, seconds, etc.
map ;s :up \| saveas! %:p:r.<C-R>=strftime("%Y%m%d")<CR>.bak \| 3sleep \| e #<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Section 5: Abbreviations and Shortcuts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Common misspellings
iabbrev teh the
iabbrev seperate separate

" Shortcut to adding a timestamp, just type YTS in insert mode.  This timestamp
" will be automatically updated on each save of the file.
iabbrev YTS <C-R>=TimeStamp()<CR>

" Shortcut for entering vax templates
iabbrev vdf VAX_D_FLOAT,11.2

" Autocommand to update existing timestamp when writing the file
" It uses the functions above to replace the time stamp and restores the
" cursor position afterwards
autocmd BufWritePre,FileWritePre *   ks|call UpdateTimeStamp()|'s

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Section 6: Filetype Specific Behavior
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" We want filetype detections, with plugins, and updated indenting rules
filetype plugin indent on

" Automatically make perl, php, and shell scripts executable.
"autocmd BufWritePost * if &ft =~ 'sh\|perl\|php'   | silent !chmod a+x <afile> 

" Speaking of comments, these improve the C-style /* comments by wrapping with
" a ** on each line.
" /* 
" ** So that your
" ** multiline comments
" ** look like this 
" */
set comments-=s1:/*,mb:*,ex:*/
set comments+=s:/*,mb:**,ex:*/
set comments+=fb:*

" Automatically create a skeleton for new .html or .php files.
au BufNewFile *.html,*.htm,*.php | silent execute "normal :set ai!\<kEnter>i<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">\<kEnter><html>\<kEnter><head>\<kEnter><style>\<kEnter></style>\<kEnter><script>\<kEnter></script>\<kEnter></head>\<kEnter><body>\<kEnter></body>\<kEnter></html>\<kEnter>\<ESC>:set ai\<kEnter>gg"

" Smart Man Pages for perl and php.  php requires a special shell script which
" is described at the top of this file.
"if filereadable("/home/fdamstra/.vim/bin/phpdoc")
"  autocmd FileType php set keywordprg=/home/fdamstra/.vim/bin/phpdoc
  " This script is two lines:
  " #! /bin/bash
  " elinks --dump 1 http://www.php.net/$1 | less
"endif
"autocmd FileType perl set keywordprg=perldoc\ -f

" Compilation checking for languages
autocmd FileType php map <C-B> :!php -l %<CR>
autocmd FileType perl map <C-B> :!perl -c %<CR>

" Fill in comment leading characters for C files
autocmd FileType c,cpp,slang set cindent
autocmd FileType c,cpp,slang set formatoptions+=ro

" For perl and css programming, have things in braces indent themselves.
autocmd FileType perl,css set smartindent

" For HTML, generally format text, but if a long line has been created, let it be.
autocmd FileType html set formatoptions+=t1

" Use real tabs for html and css to keep files slightly smaller.
autocmd FileType html,css set noexpandtab tabstop=2

" And definately don't expand tabs in Makefiles, since they're required
autocmd FileType make set noexpandtab shiftwidth=8

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Section 7: Spelling (requires ispell)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" define `Ispell' language and personal dictionary, used in several places
" below:
let IspellLang = 'english'
let PersonalDict = '~/.ispell_' . IspellLang

" try to avoid misspelling words in the first place -- have the insert mode
" <Ctrl>+N/<Ctrl>+P keys perform completion on partially-typed words by
" checking the Linux word list and the personal `Ispell' dictionary; sort out
" case sensibly (so that words at starts of sentences can still be completed
" with words that are in the dictionary all in lower case):
execute 'set dictionary+=' . PersonalDict
set dictionary+=/usr/dict/words
set complete=.,w,k
set infercase

" Spell checking operations are defined next.  They are all set to normal mode
" keystrokes beginning \s but function keys are also mapped to the most common
" ones.  The functions referred to are defined at the end of this .vimrc.

" \si ("spelling interactive") saves the current file then spell checks it
" interactively through `Ispell' and reloads the corrected version:
execute 'nnoremap \si :w<CR>:!ispell -x -d ' . IspellLang . ' %<CR>:e<CR><CR>'

" \sl ("spelling list") lists all spelling mistakes in the current buffer,
" but excludes any in news/mail headers or in ("> ") quoted text:
execute 'nnoremap \sl :w ! grep -v "^>" <Bar> grep -E -v "^[[:alpha:]-]+: " ' .
  \ '<Bar> ispell -l -d ' . IspellLang . ' <Bar> sort <Bar> uniq<CR>'

" \sh ("spelling highlight") highlights (in red) all misspelt words in the
" current buffer, and also excluding the possessive forms of any valid words
" (EG "Lizzy's" won't be highlighted if "Lizzy" is in the dictionary); with
" mail and news messages it ignores headers and quoted text; for HTML it
" ignores tags and only checks words that will appear, and turns off other
" syntax highlighting to make the errors more apparent [function at end of
" file]:
nnoremap \sh :call HighlightSpellingErrors()<CR><CR>

" \sc ("spelling clear") clears all highlighted misspellings; for HTML it
" restores regular syntax highlighting:
nnoremap \sc :if &ft == 'html' <Bar> sy on <Bar>
  \ else <Bar> :sy clear SpellError <Bar> endif<CR>

" \sa ("spelling add") adds the word at the cursor position to the personal
" dictionary (but for possessives adds the base word, so that when the cursor
" is on "Ceri's" only "Ceri" gets added to the dictionary), and stops
" highlighting that word as an error (if appropriate) [function at end of
" file]:
nnoremap \sa :call AddWordToDictionary()<CR><CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Section 8: HTML Extensions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Some automatic HTML tag insertion operations are defined next.  They are
" all set to normal mode keystrokes beginning \h.  Insert mode function keys 
" are also defined, for terminals where they work.  The functions referred to 
" are defined at the end of this .vimrc.

" \hc ("HTML close") inserts the tag needed to close the current HTML construct
" [function at end of file]:
nnoremap \hc :call InsertCloseTag()<CR>

" \hp ("HTML previous") copies the previous (non-closing) HTML tag in full,
" including attributes; repeating this straight away removes that tag and
" copies the one before it [function at end of file]:
nnoremap \hp :call RepeatTag(0)<CR>

" \hn ("HTML next") does the same thing, but copies the next tag; so \hp and
" \hn can be used to cycle backwards and forwards through the tags in the file
" (like <Ctrl>+P and <Ctrl>+N do for insert mode completion):
nnoremap \hn :call RepeatTag(1)<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Section 9: Functions 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Timestamp functionality
" Modified from http://www.michael-prokop.at/computer/config/vimrc.html
" Replaces only the first timestamp
fun TimeStamp()
  return "Last-Updated: <27 Sep 2004 17:22:31 Fred Damstra (fdamstra@cuanswers.com)>"
endfun
fun UpdateTimeStamp()
  let line = search("Last-Updated: <.*>")
  if l:line > 0
    exe l:line . "s/Last-Updated: \<.*\>/" . TimeStamp() . "/ 1"
  endif
endfun
            
"fun TimeStamp()
"  return "Last-Updated: <10 Sep 2004 11:27:06 Fred Damstra (fdamstra@cuanswers.com)>"
"endfun
"fun UpdateTimeStamp()
"  if (match(getline(1),"Last-Updated: <10 Sep 2004 11:27:06 Fred Damstra (fdamstra@cuanswers.com)> 1
"    exe "1,1 s/Last-Updated: <10 Sep 2004 11:27:06 Fred Damstra (fdamstra@cuanswers.com)>/" . TimeStamp()
"    exe "%s/Last-Updated: <10 Sep 2004 11:27:06 Fred Damstra (fdamstra@cuanswers.com)>/" . TimeStamp()
"  endif
"endfun

function MapHTMLKeys(...)
" sets up various insert mode key mappings suitable for typing HTML, and
" automatically removes them when switching to a non-HTML buffer

  " if no parameter, or a non-zero parameter, set up the mappings:
  if a:0 == 0 || a:1 != 0

    " require two backslashes to get one:
    inoremap \\ \

    " then use backslash followed by various symbols insert HTML characters:
    inoremap \& &amp;
    inoremap \< &lt;
    inoremap \> &gt;
    inoremap \. &middot;

    " em dash -- have \- always insert an em dash, and also have _ do it if
    " ever typed as a word on its own, but not in the middle of other words:
    inoremap \- &#8212;
    iabbrev _ &#8212;

    " hard space with <Ctrl>+Space, and \<Space> for when that doesn't work:
    inoremap \<Space> &nbsp;
    imap <C-Space> \<Space>

    " have the normal open and close single quote keys producing the character
    " codes that will produce nice curved quotes (and apostophes) on both Unix
    " and Windows:
    inoremap ` &#8216;
    inoremap ' &#8217;
    " then provide the original functionality with preceding backslashes:
    inoremap \` `
    inoremap \' '

    " curved double open and closed quotes (2 and " are the same key for me):
    inoremap \2 &#8220;
    inoremap \" &#8221;

    " when switching to a non-HTML buffer, automatically undo these mappings:
    autocmd BufLeave * call MapHTMLKeys(0)

  " parameter of zero, so want to unmap everything:
  else
    iunmap \\
    iunmap \&
    iunmap \<
    iunmap \>
    iunmap \-
    iunabbrev _
    iunmap \<Space>
    iunmap <C-Space>
    iunmap `
    iunmap '
    iunmap \`
    iunmap \'
    iunmap \2
    iunmap \"

    " once done, get rid of the autocmd that called this:
    autocmd BufLeave *

  endif " test for mapping/unmapping

endfunction " MapHTMLKeys()

function HighlightSpellingErrors()
" highlights spelling errors in the current window; used for the \sh operation
" defined above;
" requires the ispell, sort, and uniq commands to be in the path;
" requires the global variable IspellLang to be defined above, and to contain
" the preferred `Ispell' language;
" for mail/news messages, requires the grep command to be in the path;
" for HTML documents, saves the file to disk and requires the lynx command to
" be in the path
"
" by Smylers  http://www.stripey.com/vim/
" (inspired by Krishna Gadepalli and Neil Schemenauer's vimspell.sh)
" 
" 2000 Jun 1: for `Vim' 5.6

  " for HTML files, remove all current syntax highlighting (so that
  " misspellings show up clearly), and note it's HTML for future reference:
  if &filetype == 'html'
    let HTML = 1
    syntax clear

  " for everything else, simply remove any previously-identified spelling
  " errors (and corrections):
  else
    let HTML = 0
    if hlexists('SpellError')
      syntax clear SpellError
    endif
    if hlexists('Normal')
      syntax clear Normal
    endif
  endif

  " form a command that has the text to be checked piping through standard
  " output; for HTML files this involves saving the current file and processing
  " it with `Lynx'; for everything else, use all the buffer except quoted text
  " and mail/news headers:
  if HTML
    write
    let PipeCmd = '! lynx --dump --nolist % |'
  else
    let PipeCmd = 'write !'
    if &filetype == 'mail'
      let PipeCmd = PipeCmd . ' grep -v "^> " | grep -E -v "^[[:alpha:]-]+:" |'
    endif
  endif

  " execute that command, then generate a unique list of misspelt words and
  " store it in a temporary file:
  let ErrorsFile = tempname()
  execute PipeCmd . ' ispell -l -d '. g:IspellLang .
    \ ' | sort | uniq > ' . ErrorsFile

  " open that list of words in another window:
  execute 'split ' . ErrorsFile

  " for every word in that list ending with "'s", check if the root form
  " without the "'s" is in the dictionary, and if so remove the word from the
  " list:
  global /'s$/ execute 'read ! echo ' . expand('<cword>') .
    \ ' | ispell -l -d ' . g:IspellLang | delete
  " (If the root form is in the dictionary, ispell -l will have no output so
  " nothing will be read in, the cursor will remain in the same place and the
  " :delete will delete the word from the list.  If the root form is not in the
  " dictionary, then ispell -l will output it and it will be read on to a new
  " line; the delete command will then remove that misspelt root form, leaving
  " the original possessive form in the list!)

  " only do anything if there are some misspellings:
  if strlen(getline('.')) > 0

    " if (previously noted as) HTML, replace each non-alphanum char with a
    " regexp that matches either that char or a &...; entity:
    if HTML
      % substitute /\W/\\(&\\|\&\\(#\\d\\{2,4}\\|\w\\{2,8}\\);\\)/e
    endif

    " turn each mistake into a `Vim' command to place it in the SpellError
    " syntax highlighting group:
    % substitute /^/syntax match SpellError !\\</
    % substitute /$/\\>!/
  endif

  " save and close that file (so switch back to the one being checked):
  exit

  " make syntax highlighting case-sensitive, then execute all the match
  " commands that have just been set up in that temporary file, delete it, and
  " highlight all those words in red:
  syntax case match
  execute 'source ' . ErrorsFile
  call delete(ErrorsFile)
  highlight SpellError term=reverse ctermfg=DarkRed guifg=Red

  " with HTML, don't mark any errors in e-mail addresses or URLs, and ignore
  " anything marked in a fix-width font (as being computer code):
  if HTML
    syntax case ignore
    syntax match Normal !\<[[:alnum:]._-]\+@[[:alnum:]._-]\+\.\a\+\>!
    syntax match Normal
      \ !\<\(ht\|f\)tp://[-[:alnum:].]\+\a\(/[-_.[:alnum:]/#&=,]*\)\=\>!
    syntax region Normal start=!<Pre>! end=!</Pre>!
    syntax region Normal start=!<Code>! end=!</Code>!
    syntax region Normal start=!<Kbd>! end=!</Kbd>!
  endif

endfunction " HighlightSpellingErrors()

function AddWordToDictionary()
" adds the word under the cursor to the personal dictonary; used for the \sa
" operation defined above;
" requires the global variable PersonalDict to be defined above, and to contain
" the `Ispell' personal dictionary;
"
" by Smylers  http://www.stripey.com/vim/
" 
" 2000 Apr 30: for `Vim' 5.6

  " get the word under the cursor, including the apostrophe as a word character
  " to allow for words like "won't", but then ignoring any apostrophes at the
  " start or end of the word:
  set iskeyword+='
  let Word = substitute(expand('<cword>'), "^'\\+", '', '')
  let Word = substitute(Word, "'\\+$", '', '')
  set iskeyword-='

  " override any SpellError highlighting that might exist for this word,
  " `highlighting' it as normal text:
  execute 'syntax match Normal #\<' . Word . '\>#'

  " remove any final "'s" so that possessive forms don't end up in the
  " dictionary, then add the word to the dictionary:
  let Word = substitute(Word, "'s$", '', '')
  execute '!echo "' . Word . '" >> ' . g:PersonalDict
endfunction " AddWordToDictionary()

function InsertCloseTag()
" inserts the appropriate closing HTML tag; used for the \hc operation defined
" above;
" requires ignorecase to be set, or to type HTML tags in exactly the same case
" that I do;
" doesn't treat <P> as something that needs closing;
" clobbers register z and mark z
" 
" by Smylers  http://www.stripey.com/vim/
" 2000 May 4

  if &filetype == 'html'

    " list of tags which shouldn't be closed:
    let UnaryTags = ' Area Base Br DD DT HR Img Input LI Link Meta P Param '

    " remember current position:
    normal mz

    " loop backwards looking for tags:
    let Found = 0
    while Found == 0
      " find the previous <, then go forwards one character and grab the first
      " character plus the entire word:
      execute "normal ?\<LT>\<CR>l"
      normal "zyl
      let Tag = expand('<cword>')

      " if this is a closing tag, skip back to its matching opening tag:
      if @z == '/'
        execute "normal ?\<LT>" . Tag . "\<CR>"

      " if this is a unary tag, then position the cursor for the next
      " iteration:
      elseif match(UnaryTags, ' ' . Tag . ' ') > 0
        normal h

      " otherwise this is the tag that needs closing:
      else
        let Found = 1

      endif
    endwhile " not yet found match

    " create the closing tag and insert it:
    let @z = '</' . Tag . '>'
    normal `z
    if col('.') == 1
      normal "zP
    else
      normal "zp
    endif

  else " filetype is not HTML
    echohl ErrorMsg
    echo 'The InsertCloseTag() function is only intended to be used in HTML ' .
      \ 'files.'
    sleep
    echohl None

  endif " check on filetype

endfunction " InsertCloseTag()


function RepeatTag(Forward)
" repeats a (non-closing) HTML tag from elsewhere in the document; call
" repeatedly until the correct tag is inserted (like with insert mode <Ctrl>+P
" and <Ctrl>+N completion), with Forward determining whether to copy forwards
" or backwards through the file; used for the \hp and \hn operations defined
" above;
" requires preservation of marks i and j;
" clobbers register z
" 
" by Smylers  http://www.stripey.com/vim/
" 
" 2000 May 4: for `Vim' 5.6

  if &filetype == 'html'

    " if the cursor is where this function left it, then continue from there:
    if line('.') == line("'i") && col('.') == col("'i")
      " delete the tag inserted last time:
      if col('.') == strlen(getline('.'))
        normal dF<x
      else
        normal dF<x
        if col('.') != 1
          normal h
        endif
      endif
      " note the cursor position, then jump to where the deleted tag was found:
      normal mi`j

    " otherwise, just store the cursor position (in mark i):
    else
      normal mi
    endif

    if a:Forward
      let SearchCmd = '/'
    else
      let SearchCmd = '?'
    endif

    " find the next non-closing tag (in the appropriate direction), note where
    " it is (in mark j) in case this function gets called again, then yank it
    " and paste a copy at the original cursor position, and store the final
    " cursor position (in mark i) for use next time round:
    execute "normal " . SearchCmd . "<[^/>].\\{-}>\<CR>mj\"zyf>`i"
    if col('.') == 1
      normal "zP
    else
      normal "zp
    endif
    normal mi

  else " filetype is not HTML
    echohl ErrorMsg
    echo 'The RepeatTag() function is only intended to be used in HTML files.'
    sleep
    echohl None

  endif

endfunction " RepeatTag()

" Autocomment curlies.. we'll see if I like this.
" Nope, don't like it, because it messes up folding
"au BufNewFile,BufRead *.c,*.cc,*.C,*.h,*.cpp,*.pl,*.pm,*.php imap } <ESC>:call CurlyBracket()<CR>a
"function CurlyBracket()
"  let l:my_linenum = line(".")
"  iunmap }
"  sil exe "normal i}"
"  imap } <ESC>:call CurlyBracket()<CR>a
"  let l:result1 =  searchpair('{','','}','bW')
"  if (result1 > 0)
"    let l:my_string = substitute(getline("."), '^\s*\(.*\)\s*{', '\1', "")
"    sil exe ":" . l:my_linenum
"    sil exe "normal a //" . l:my_string
"  endif
"endfunction

" Comment out lines with a simple visual command.
fun CommentLines()
  sil exe ":s@^@".g:Comment."@g"
  sil exe ":s@$@".g:EndComment."@g"
endfun
" Comment lines back in.  This is broken.  Anybody have a good solution?
fun UnCommentLines()
  let l:escapedComment = substitute(g:Comment, "\*", "\\*", "");
  let l:escapedEndComment = substitute(g:EndComment, '\*', '\\*', "");
  sil exe ":s@^".l:escapedComment."\\(.*\\)".l:escapedEndComment."$@\\1@g"
endfun
augroup filetypedetect
  au BufRead,BufNewFile *.inc,*.ihtml,*.html,*.tpl,*.class let Comment="<!-- " | let EndComment=" -->"
  au BufRead,BufNewFile *.sh,*.pl*.tcl let Comment="#" | let EndComment=""
  au BufRead,BufNewFile *.js let Comment="//" | let EndComment=""
  au BufRead,BufNewFile *.cc,*.cpp,*.cxx,*.php let Comment="//" | let EndComment=""
  au BufRead,BufNewFile *.c,*.h let Comment="/* " | let EndComment=" */"
augroup END

" This is the command to center the current line on the screen, but I can't
" figure out how to get it to automagically do it.
"autocmd BufRead * jzz
