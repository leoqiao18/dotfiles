(provide 'qnix/proof-general)

(use-package proof-general
  :config
  ;; the splash of general is kinda weird
  (setq proof-splash-enable nil)
  ;; skip comments when stepping through proofs
  (setq proof-script-fly-past-comments t)
  )
