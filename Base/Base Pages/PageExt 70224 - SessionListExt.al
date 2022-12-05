/*pageextension 70224 SessionListExt extends "Session List"
{
        object id = 9506

    layout
    {



        addafter("Control 16")
        {
            field("Client Computer Name"; "Client Computer Name")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Database Name"; "Database Name")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Session Unique ID"; "Session Unique ID")
            {
                Editable = false;
                ApplicationArea = All;
            }
            group(Control1102152007)
            {
                Editable = false;
                ShowCaption = false;
                grid(Control1102152006)
                {
                    ShowCaption = false;
                    group(Control1102152005)
                    {
                        ShowCaption = false;
                        field("FORMAT(Rec.COUNT)"; FORMAT(Rec.COUNT))
                        {
                            Editable = false;
                            ApplicationArea = All;
                        }
                    }
                }
            }
        }
    }
    actions
    {



        modify("Debug Selected Session")
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify("Debug Next Session")
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify("Start Full SQL Tracing")
        {
            Promoted = true;
        }
        modify("Stop Full SQL Tracing")
        {
            Promoted = true;
        }
        modify(Subscriptions)
        {


            Promoted = true;
        }
        addafter("Debug Next Session")
        {
            action("Kill Session")
            {
                Caption = 'Kill Session';
                Image = Server;
                ApplicationArea = All;

                trigger OnAction();
                begin


                    IF CONFIRM('Kill Session') THEN BEGIN
                        IF "User ID" = 'ERPSERVER\ADMINISTRATOR' THEN
                            ERROR('YOU CANT DELETE SESSION')
                        ELSE BEGIN
                            STOPSESSION("Session ID");
                            COMMIT;
                        END;
                    END;
                    //STOPSESSION("Session ID" );
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        IF NOT (SMTP_MAIL.Permission_Checking(USERID, 'SESSIONKILLING'))
                    THEN
            ERROR('You Don"t have Permissions ' + USERID);
    end;

    trigger OnDeleteRecord(): Boolean
    var
        myInt: Integer;
    begin
        IF ("User ID" = 'ERPSERVER\ADMINISTRATOR') AND ("Client Type" <> "Client Type"::Background) THEN
            ERROR('YOU CANT DELETE SESSION')
        ELSE BEGIN
            STOPSESSION("Session ID");
            COMMIT;
        END;
    end;




    var
        SMTP_MAIL: Codeunit "SMTP Mail";




}*/

