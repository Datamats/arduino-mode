(defun arduino-serial-select-linux ()
	(let ((serial-interfaces (directory-files "/dev" 'true "\\(ttyACM\\|ttyAMA\\)")))
	  	(print (length serial-interfaces))
	  	(if (> (length serial-interfaces) 1)
	  		(ido-completing-read "Select the serial interface: " serial-interfaces)
		 	(if (> (length serial-interfaces) 0)
				(first serial-interfaces)
			 	(error "No valid serial interface found!")))))
	
(defun arduino-serial-get-serial (force)
	"Get the current serial or select it if there is multiple candidates"
  	(if (and (boundp 'arduino-serial-serial-port) (not force) (file-exists-p arduino-serial-serial-port))
  		arduino-serial-serial-port
  	  	(if (eq system-type 'gnu/linux)
			(let ((serial (arduino-serial-select-linux)))
			  (setq arduino-serial-serial-port serial)
			 serial))))

(defun arduino-serial-select ()
	"Select the serial port to use for arduino usage"
  	(interactive)
  	(arduino-serial-get-serial 'true)
	(message arduino-serial-serial-port))
