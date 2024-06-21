import os
from ftplib import FTP


def upload_to_ftp(filepath):
    ftp = FTP("ftp.haraldmueller.ch")  # Host-Adresse
    ftp.login(user="schueler", passwd="studentenpasswort")
    with open(filepath, "rb") as file:
        ftp.storbinary("STOR " + os.path.basename(filepath), file)
    ftp.quit()


upload_to_ftp("./2024-06-21_09-33_newMailadr_Klasse_Nachname.zip")
