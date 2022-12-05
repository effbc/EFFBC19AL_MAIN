xmlport 50075 Routings
{
    //  User.RESET;
    //  User.SETFILTER(User.EmployeeID,"<ItemJournalLine>"."No.");
    //  IF User.FINDFIRST THEN
    //  "<ItemJournalLine>"."User ID":=User."User Name";

    FieldSeparator = ',';
    Format = VariableText;
    FormatEvaluate = Legacy;

    schema
    {
        textelement(ItemJournalLines)
        {
            tableelement("<itemjournalline>"; "Item Journal Line")
            {
                AutoSave = false;
                XmlName = 'ItemJournalLine';
                UseTemporary = true;
                fieldelement(PostingDate; "<ItemJournalLine>"."Posting Date")
                {
                }
                fieldelement(Test_No; "<ItemJournalLine>"."No.")
                {
                }
                fieldelement(ProdOrderNo; "<ItemJournalLine>"."Order No.")
                {
                }
                fieldelement(SourceNo; "<ItemJournalLine>"."Source No.")
                {
                }
                fieldelement(OperationNo; "<ItemJournalLine>"."Operation No.")
                {
                }
                fieldelement(RunTime; "<ItemJournalLine>"."Run Time")
                {
                }

                trigger OnAfterInsertRecord();
                begin
                    User.Reset;
                    User.SetFilter(User.EmployeeID, "<ItemJournalLine>"."No.");
                    if User.FindFirst then
                        "<ItemJournalLine>"."User ID" := User."User ID"//User."User Name"//EFFUPG
                    else
                        Error(Text001, "<ItemJournalLine>"."No.");

                    IJL.Reset;
                    IJL.SetFilter(IJL."Journal Template Name", 'OUTPUT');
                    IJL.SetFilter(IJL."Journal Batch Name", 'MPROJ|SHFOJ|MPRTHREEOJ|MPRTWOOJ|PONE-OJ');
                    IJL.SetFilter(IJL."Order No.", "<ItemJournalLine>"."Order No.");
                    IJL.SetFilter(IJL."Source No.", "<ItemJournalLine>"."Source No.");
                    IJL.SetFilter(IJL."Operation No.", "<ItemJournalLine>"."Operation No.");
                    IJL.SetFilter(IJL."Run Time", '%1', 0);
                    if IJL.FindFirst then begin
                        if ("<ItemJournalLine>"."No." <> 'MPR') or ("<ItemJournalLine>"."No." <> 'SHF') then begin
                            IJL.Type := 1;
                            MC.Reset;
                            MC.SetFilter(MC."No.", "<ItemJournalLine>"."No.");
                            if MC.FindFirst then
                                IJL.Description := MC.Name;
                        end;
                        IJL."Posting Date" := "<ItemJournalLine>"."Posting Date";
                        IJL."No." := "<ItemJournalLine>"."No.";
                        IJL."Run Time" := "<ItemJournalLine>"."Run Time";
                        IJL."Run Time (Base)" := "<ItemJournalLine>"."Run Time";
                        IJL."User ID" := "<ItemJournalLine>"."User ID";
                        IJL.Modify;
                        k := k + 1;
                    end;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnPostXmlPort();
    begin
        Message(Format(k));
    end;

    var
        IJL: Record "Item Journal Line";
        k: Integer;
        MC: Record "Machine Center";
        User: Record "User Setup";//EFFUPG
        User_Id: Code[50];
        Text001: Label 'The UserID %1 is not valid. Please make an Entry for %1 in User Table';
}

