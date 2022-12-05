tableextension 70146 ChangeLogEntryExt extends "Change Log Entry"
{

    fields
    {


    }
    keys
    {
        key(Key6; "Table No.", "Primary Key Field 2 Value", "Primary Key Field 3 Value", "Date and Time")
        {

        }
    }

    trigger OnInsert()
    begin
        /* IF "Table No." = 36 THEN BEGIN
            Subject := 'Change Log Entry Details(Insertion) :: Order No - ' + "Primary Key Field 2 Value" + 'Field No - ' + FORMAT("Field No.");
            SMTP_MAIL.CreateMessage('ERP', 'erp@efftronics.com', 'erp@efftronics.com', Subject, '', TRUE);
            SMTP_MAIL.AppendBody('<html><body><table>');
            SMTP_MAIL.AppendBody('<th><td>Order No</td><td>Type of Change</td><td>Old Value</td><td>New Value</td><td>User</td><td>PrimaryKey-Field3</td><td>Date and Time</td></th>');
            SMTP_MAIL.AppendBody('<tr><td>' + "Primary Key Field 2 Value" + '<td>');
            CASE "Type of Change" OF
                0:
                    SMTP_MAIL.AppendBody('Insertion');
                1:
                    SMTP_MAIL.AppendBody('Modification');
                2:
                    SMTP_MAIL.AppendBody('Deletion');
            END;
            SMTP_MAIL.AppendBody('</td><td>' + "Old Value" + '</td><td>' + "New Value" + '</td><td>' + "User ID" + '</td><td>' + "Primary Key Field 3 Value" + '</td><td>' + FORMAT("Date and Time") + '</td></tr>');
            SMTP_MAIL.AppendBody('</table>');
            SMTP_MAIL.AppendBody('<br/><br/>*********** This is auto generated mail from ERP ************</body></html>');
            //SMTP_MAIL.Send;
        END; */

        /* IF "Table No." = 36 THEN BEGIN
            Subject := 'Change Log Entry Details(Insertion) :: Order No - ' + "Primary Key Field 2 Value" + 'Field No - ' + FORMAT("Field No.");
            Recipients.Add('erp@efftronics.com');
            //Recipients.Add('erp@efftronics.com');
            EmailMessage.Create(Recipients, Subject, Body, TRUE);
            Body += '<html><body><table>';
            Body += '<th><td>Order No</td><td>Type of Change</td><td>Old Value</td><td>New Value</td><td>User</td><td>PrimaryKey-Field3</td><td>Date and Time</td></th>';
            Body += '<tr><td>' + "Primary Key Field 2 Value" + '<td>';
            case "Type of Change" of
                "Type of Change"::Insertion:
                    Body += 'Insertion';
               "Type of Change"::Modification:
                    Body += 'Modification';
                "Type of Change"::Deletion:
                    Body += 'Deletion';
            end;
            Body += '</td><td>' + "Old Value" + '</td><td>' + "New Value" + '</td><td>' + "User ID" + '</td><td>' + "Primary Key Field 3 Value" + '</td><td>' + FORMAT("Date and Time") + '</td></tr>';
            Body += '</table>';
            Body += '<br/><br/>*********** This is auto generated mail from ERP ************</body></html>';
            Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
        end; */
    end;

    trigger OnDelete()
    begin
        /* IF "Table No." = 36 THEN
               BEGIN
                   Subject := 'Change Log Entry Details(Deletion) :: Order No - ' + "Primary Key Field 2 Value" + 'Field No - '+ FORMAT("Field No.");
                   SMTP_MAIL.CreateMessage('ERP','erp@efftronics.com','erp@efftronics.com',Subject,'',TRUE);
                   SMTP_MAIL.AppendBody('<html><body><table>');
                   SMTP_MAIL.AppendBody('<th><td>Order No</td><td>Type of Change</td><td>Old Value</td><td>New Value</td><td>User</td><td>PrimaryKey-Field3</td><td>Date and Time</td></th>');
                   SMTP_MAIL.AppendBody('<tr><td>'+"Primary Key Field 2 Value"+ '<td>');
                   CASE "Type of Change" OF
                     0 : SMTP_MAIL.AppendBody('Insertion');
                     1 : SMTP_MAIL.AppendBody('Modification');
                     2 : SMTP_MAIL.AppendBody('Deletion');
                   END;
                   SMTP_MAIL.AppendBody('</td><td>'+"Old Value"+'</td><td>'+"New Value" + '</td><td>'+"User ID"+'</td><td>'+"Primary Key Field 3 Value"+'</td><td>'+FORMAT("Date and Time")+'</td></tr>');
                   SMTP_MAIL.AppendBody('</table>');
                   SMTP_MAIL.AppendBody('<br/><br/>*********** This is auto generated mail from ERP ************</body></html>');
                //   SMTP_MAIL.Send;
               END; */

        /* IF "Table No." = 36 THEN BEGIN
            Subject := 'Change Log Entry Details(Deletion) :: Order No - ' + "Primary Key Field 2 Value" + 'Field No - ' + FORMAT("Field No.");
            Recipients.Add('erp@efftronics.com');
            //Recipients.Add('erp@efftronics.com');
            EmailMessage.Create(Recipients, Subject, Body, TRUE);
            Body += '<html><body><table>';
            Body += '<th><td>Order No</td><td>Type of Change</td><td>Old Value</td><td>New Value</td><td>User</td><td>PrimaryKey-Field3</td><td>Date and Time</td></th>';
            Body += '<tr><td>' + "Primary Key Field 2 Value" + '<td>';
            case "Type of Change" of
                "Type of Change"::Insertion:
                    Body += 'Insertion';
                "Type of Change"::Modification:
                    Body += 'Modification';
                "Type of Change"::Deletion:
                    Body += 'Deletion';
            end;
            Body += '</td><td>' + "Old Value" + '</td><td>' + "New Value" + '</td><td>' + "User ID" + '</td><td>' + "Primary Key Field 3 Value" + '</td><td>' + FORMAT("Date and Time") + '</td></tr>';
            Body += '</table>';
            Body += '<br/><br/>*********** This is auto generated mail from ERP ************</body></html>';
            Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
        end; */
    end;



    var
        Subject: Text[100];
        Body: Text;
        //EmailMessage: Codeunit 8904;
        //Email: Codeunit 8901;
        Recipients: List of [Text];
}

