import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.base import MIMEBase
from email import encoders
import os


def send_email(archive_path):
    from_address = "meinemail@mail.com"
    to_address = "empfänder@mail.com"
    subject = "Neue TBZ-Mailadressen [{}]".format(len(os.listdir("csv_output")))

    message = MIMEMultipart()
    message["From"] = from_address
    message["To"] = to_address
    message["Subject"] = subject
    body = "Lieber Lehrer,\n\nDie Emailadressen-Generierung ist beendet. Es wurden {} erzeugt.\n\nBei Fragen kontaktiere bitte meinemail@mail.com\n\nGruss Max Mustermann".format(
        len(os.listdir("csv_output"))
    )
    message.attach(MIMEText(body, "plain"))

    attachment = open(archive_path, "rb")
    part = MIMEBase("application", "octet-stream")
    part.set_payload((attachment).read())
    encoders.encode_base64(part)
    part.add_header(
        "Content-Disposition",
        "attachment; filename= %s" % os.path.basename(archive_path),
    )
    message.attach(part)

    server = smtplib.SMTP("smtp.example.com", 587)
    server.starttls()
    server.login(from_address, "password")
    text = message.as_string()
    server.sendmail(from_address, to_address, text)
    server.quit()


send_email("./2024-06-21_09-33_newMailadr_Klasse_Nachname.zip")
