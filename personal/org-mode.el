(setq org-capture-templates
      `(("w" "Work-related Task"  entry
        (file "~/Dropbox/notes/tasks.org")
        "* TODO %? \n %t" :empty-lines 1)
      ("e" "Work-related Questions"  entry
        (file "~/Dropbox/notes/questions.org")
        "* Topic %? \n* TODO  \n %t " :empty-lines 1))
)
