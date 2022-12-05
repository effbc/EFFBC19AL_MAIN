page 50010 "Modify Material Issue"
{
    PageType = Card;
    Permissions = TableData "Item Ledger Entry" = rm,
                  TableData "Value Entry" = rm;
    SourceTable = "Posted Material Issues Header";

    layout
    {
        area(content)
        {
            group(Modification)
            {
                field("Current Id"; "Current Id")
                {
                    Caption = 'Current user Id';
                    MultiLine = false;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        "Current Id" := '';
                        User.RESET;
                        IF PAGE.RUNMODAL(9800, User) = ACTION::LookupOK THEN
                            "Current Id" := User."User Name";
                    end;
                }
                field("Modified Id"; "Modified Id")
                {
                    Caption = 'Modify User ID';
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        "Modified Id" := '';
                        User.RESET;
                        IF PAGE.RUNMODAL(9800, User) = ACTION::LookupOK THEN
                            "Modified Id" := User."User Name";
                    end;
                }
            }
            group(Locations)
            {
                Visible = true;
                field("<From STR>"; "From STR")
                {
                    Caption = 'From STR';
                    MultiLine = false;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        /*Loca.RESET;
                        IF PAGE.RUNMODAL(15,Loca) = ACTION:: LookupOK THEN
                          "From STR" := Loca.Code;*/

                    end;
                }
                field("<Site Location>"; "To Division")
                {
                    Caption = 'Site Location';
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        DIMVAL.RESET;
                        IF PAGE.RUNMODAL(560, DIMVAL) = ACTION::LookupOK THEN
                            "To Division" := DIMVAL.Code;
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Action1102152005)
            {
                action("Change the User")
                {
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //MESSAGE('Changing the User in Posted Material Issues');
                        //IF NOT (USERID IN ['EFFTRONICS\DMADHAVI','EFFTRONICS\MARY','EFFTRONICS\TULASI','EFFTRONICS\VISHNUPRIYA','EFFTRONICS\VIJAYA','EFFTRONICS\SUJANI'])
                        IF NOT (USERID IN ['EFFTRONICS\TULASI', 'EFFTRONICS\MARY', 'EFFTRONICS\VISHNUPRIYA'])
                         THEN
                            ERROR('You donot have rights to modify the Userid');

                        IF "Current Id" = '' THEN
                            ERROR('select the User ID to modify');
                        IF "To Division" <> '' THEN
                            ERROR('don''t enter the Division Code');

                        IF "Modified Id" = '' THEN
                            ERROR('Enter the new User ID modify');
                        IF "Modified Id" = "Current Id" THEN
                            ERROR('Both users are same, verify once.');
                        //added by Vishnu on 01-08-2019 to change the material with in the same  people (Like Persons training ID-Name and Persons Employee id Name Should be same)
                        IF USERID <> 'EFFTRONICS\VISHNUPRIYA' THEN BEGIN
                            Userstable.RESET;
                            Userstable.SETFILTER("User Name", "Current Id");
                            IF Userstable.FINDFIRST THEN
                                OldEmployeeName := Userstable."Full Name";
                            Userstable.RESET;
                            Userstable.SETFILTER("User Name", "Modified Id");
                            IF Userstable.FINDFIRST THEN
                                NewEmployeeName := Userstable."Full Name";
                            IF UPPERCASE(DELCHR(OldEmployeeName, '<>', ' ')) <> UPPERCASE(DELCHR(NewEmployeeName, '<>', ' ')) THEN
                                ERROR('You Can''t Modify the Records of %1 with %2 ', OldEmployeeName, NewEmployeeName);
                        END;
                        //end by Vishnu on 01-08-2019 to change the material with in the same  people (Like Persons training ID-Name and Persons Employee id Name Should be same)


                        //COMMENTED BY VISHNU
                        /*
                        {IF "Modified Id" = "Current Id" THEN
                          MESSAGE('Both users are same, verify once.');}
                        IF "From STR" = '' THEN
                          MESSAGE('Select the from location code');
                        IF "To Division" = '' THEN
                          MESSAGE('Select the to location code');
                        IF "From STR" <> 'STR' THEN
                          MESSAGE('You Can not move the Stock!');
                        
                        RESET;
                        SETRANGE("Posting Date",010117D,010119D);
                        SETRANGE("User ID",'EFFTRONICS\CHHARIKA');
                        "No.of records" := COUNT;
                        ILE.SETCURRENTKEY("Document No.","Posting Date");
                        MESSAGE('No.of Records- '+FORMAT("No.of records"));
                        ILE.SETRANGE("Posting Date",010117D,010119D);
                        //ILE.FINDSET;
                        IF FINDSET THEN
                        REPEAT
                        
                          ILE.SETFILTER("Document No.","No.");
                          ILE.SETFILTER(Open,FORMAT(TRUE));
                          ILE.FINDSET;
                          ILE.MODIFYALL("Location Code","To Division");
                        UNTIL NEXT = 0;
                        */









                        Rec.RESET;
                        //SETFILTER("Posting Date",010118D,100918D);
                        Rec.SETFILTER("User ID", "Current Id");
                        IF Rec.FINDSET THEN BEGIN
                            User.RESET;
                            User.SETRANGE(User."User Name", "Modified Id");
                            IF User.FINDFIRST THEN BEGIN
                                Rec.MODIFYALL("Modified UserID", TRUE);
                                Rec.MODIFYALL("User ID", "Modified Id");
                                Rec.MODIFYALL("Resource Name", User."Full Name");
                                MESSAGE(FORMAT(Rec.COUNT) + ' records have been updated.');
                            END;
                        END;



                        //ORIGINAL CODE


                        /*
                        RESET;
                        
                        SETRANGE("User ID","Current Id");
                        IF FINDSET THEN
                        BEGIN
                          User.RESET;
                          User.SETRANGE(User."User Name","Modified Id");
                          IF User.FINDFIRST THEN
                            MODIFYALL("Resource Name",User."Full Name");
                          MODIFYALL("Modified UserID",TRUE);
                          MESSAGE(FORMAT(COUNT)+' records have been updated.');
                          MODIFYALL("User ID","Modified Id");
                        END;
                        */

                    end;
                }
                action("Change SITE LOCATION")
                {
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        IF ("Current Id" <> '') AND ("Modified Id" = '') AND ("To Division" <> '') AND (USERID IN ['EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\TULASI', 'EFFTRONICS\NAGALAKSHMI']) THEN BEGIN
                            t1 := "To Division";
                            PostedMaterialHe.RESET;
                            PostedMaterialHe.SETCURRENTKEY("Prod. Order No.", "Prod. Order Line No.");
                            PostedMaterialHe.SETFILTER("User ID", "Current Id");
                            PostedMaterialHe.SETFILTER("Prod. Order No.", 'EFF08TOL01');
                            IF PostedMaterialHe.FINDSET THEN
                                //MESSAGE(FORMAT(PostedMaterialHe.COUNT));
                                REPEAT
                                    PostedMaterialHe."Transfer-to Code" := 'SITE';
                                    PostedMaterialHe."Shortcut Dimension 2 Code" := t1;
                                    PostedMaterialLin.RESET;
                                    PostedMaterialLin.SETFILTER("Document No.", PostedMaterialHe."No.");
                                    IF PostedMaterialLin.FINDSET THEN
                                        REPEAT
                                        BEGIN
                                            PostedMaterialLin."Transfer-to Code" := 'SITE';
                                            PostedMaterialLin."Shortcut Dimension 2 Code" := t1;
                                            PostedMaterialLin.MODIFY;
                                        END;
                                        UNTIL PostedMaterialLin.NEXT = 0;
                                    ILE.RESET;
                                    ILE.SETCURRENTKEY("Document No.", "Document Type", "Document Line No.");
                                    ILE.SETFILTER("Document No.", PostedMaterialHe."No.");
                                    IF ILE.FINDSET THEN
                                        REPEAT
                                        BEGIN
                                            ILE."Global Dimension 2 Code" := t1;
                                            IF ILE."Location Code" = 'TCE' THEN
                                                ILE."Location Code" := 'SITE';
                                            ILE.MODIFY;
                                        END;
                                        UNTIL ILE.NEXT = 0;
                                    VE.RESET;
                                    VE.SETCURRENTKEY("Document No.");
                                    VE.SETFILTER("Document No.", PostedMaterialHe."No.");
                                    IF VE.FINDSET THEN
                                        REPEAT
                                        BEGIN
                                            VE."Global Dimension 2 Code" := t1;
                                            IF VE."Location Code" = 'TCE' THEN
                                                VE."Location Code" := 'SITE';
                                            VE.MODIFY;
                                        END;
                                        UNTIL VE.NEXT = 0;
                                    MESSAGE(FORMAT(PostedMaterialHe."No."));
                                    PostedMaterialHe.MODIFY;
                                UNTIL PostedMaterialHe.NEXT = 0;
                        END
                        ELSE
                            ERROR('Either you don not have right or need to fill "Current Id" and "To Division"');
                    end;
                }
            }
        }
    }

    var
        "Current Id": Code[50];
        "Modified Id": Code[50];
        User: Record User;
        "From STR": Code[10];
        "To Division": Code[10];
        Loca: Record Location;
        DIMVAL: Record "Dimension Value";
        "No.of records": Integer;
        ILE: Record "Item Ledger Entry";
        PMIL: Record "Posted Material Issues Line";
        Userstable: Record User;
        OldEmployeeName: Text[100];
        NewEmployeeName: Text[100];
        PostedMaterialHe: Record "Posted Material Issues Header";
        PostedMaterialLin: Record "Posted Material Issues Line";
        VE: Record "Value Entry";
        t1: Text;
}

