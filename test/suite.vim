let s:suite  = themis#suite('ctrlp-gonosen test')
let s:assert = themis#helper('assert')

let s:V  = vital#of('gonosen')
let s:FP = s:V.import('System.Filepath')

let s:sep = g:gonosen#separator

function! s:suite.load_bookmarks_test() abort
  let file = s:FP.join(getcwd(), 'test', 'files', 'local', 'bookmark.txt')
  let ret  = gonosen#load_bookmarks(file)
  call s:assert.equals(ret, ['./autoload' . s:sep . './autoload'])
endfunction

function! s:suite.load_repositories_test() abort
  let g:gonosen#ghq_command = 'null'
  let ret = gonosen#load_repositories()
  call s:assert.empty(ret)

  let g:gonosen#ghq_command =
      \ s:FP.join(getcwd(), 'test', 'files', 'ghq', 'stub')
  let ret = gonosen#load_repositories()
  call s:assert.equals(ret, [
      \ 'foo/bar' . s:sep . '/path/to/src/foo/bar',
      \ 'bar/baz' . s:sep . '/path/to/src/bar/baz'])
endfunction

function! s:suite.load_unite_bookmarks_test() abort
  let g:unite_source_bookmark_directory =
      \ s:FP.join(getcwd(), 'test', 'files', 'unite', 'bookmark')
  let ret = gonosen#load_unite_bookmarks()
  call s:assert.equals(ret, [
      \ 'foo' . s:sep . '~/unite/bar/',
      \ 'hello' . s:sep . '~/unite/world/'])
endfunction

function! s:suite.load_ctrlp_bookmarks_test() abort
  let g:gonosen#ctrlp_bookmark_file =
      \ s:FP.join(getcwd(), 'test', 'files', 'ctrlp', 'cache.txt')
  let ret = gonosen#load_ctrlp_bookmarks()
  call s:assert.equals(ret, [
      \ 'foo' . s:sep . '~/ctrlp/bar',
      \ 'hello' . s:sep . '~/ctrlp/world'])
endfunction
