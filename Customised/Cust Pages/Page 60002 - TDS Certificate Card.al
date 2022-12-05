page 60002 "TDS Certificate Card"
{
    // version B2B1.0,Rev01

    CardPageID = "TDS Certificate Details";
    PageType = Card;
    SourceTable = "TDS Certificate Details";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Customer Acc.No."; Rec."Customer Acc.No.")
                {
                    ApplicationArea = All;
                }
                field("Invoice No."; Rec."Invoice No.")
                {
                    ApplicationArea = All;
                }
                field("TDS / Work Tax Amount"; Rec."TDS / Work Tax Amount")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("TDS Certificate No."; Rec."TDS Certificate No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Certificate Date"; Rec."Certificate Date")
                {
                    ApplicationArea = All;
                }
                field("Receipt Date"; Rec."Receipt Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&TDS")
            {
                Caption = '&TDS';
                separator(Action1102152026)
                {
                }
                action(Release)
                {
                    Caption = 'Release';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        TDSCertificate: Record "TDS Certificate Details";
                    begin
                        Rec.TESTFIELD("Document No.");
                        Rec.TESTFIELD("TDS Certificate No.");
                        TDSCertificate.SETRANGE("Document No.", Rec."Document No.");
                        IF TDSCertificate.FINDFIRST THEN BEGIN
                            TDSCertificate.Status := TDSCertificate.Status::Released;
                            TDSCertificate.MODIFY;
                        END;
                        CurrPage.UPDATE;
                    end;
                }
            }
        }
    }
}

