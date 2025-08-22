(setq languagetool-java-arguments '("-Dfile.encoding=UTF-8")
        languagetool-console-command "~/.languagetool/LanguageTool-6.5/languagetool-commandline.jar"
        languagetool-server-command "~/.languagetool/LanguageTool-6.5/languagetool-server.jar")

(global-set-key (kbd "C-c 1") 'languagetool-check)
(global-set-key (kbd "C-c 2") 'languagetool-correct-buffer)
