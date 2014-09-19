(TeX-add-style-hook "status_review1"
 (lambda ()
    (LaTeX-add-labels
     "sec:sponsor_update"
     "sec:team_update"
     "sec:project_discussion")
    (TeX-run-style-hooks
     "assignment"
     ""
     "latex2e"
     "scrartcl10"
     "scrartcl"
     "fontsize=11pt"
     "paper=a4")))

