tableextension 70177 JobQueueLogEntryExt extends "Job Queue Log Entry"
{

    fields
    {

    }
    trigger OnInsert()
    begin
        /* IF ("Object Type to Run"="Object Type to Run"::Codeunit) AND("Object ID to Run"=60018) THEN
               BEGIN
                 Mail_From :='erp@efftronics.com';
                 Mail_To := 'erp@efftronics.com';
                 Subject := 'Job Queue Status'+FORMAT(Status);
                 Body := "Error Message";
                 SMTP_MAIL.CreateMessage('ERP',Mail_From,Mail_To,Subject,Body,TRUE);
                 SMTP_MAIL.Send;
               END; */
    END;

    var
        Body: Text;
        Subject: Text;
        Mail_To: Text;
        Mail_From: Text;
}
