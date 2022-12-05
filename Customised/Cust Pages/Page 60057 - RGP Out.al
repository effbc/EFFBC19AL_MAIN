page 60057 "RGP Out"
{
    // version B2B1.0,Cal1.0,Rev01

    Editable = true;
    PageType = Document;
    SourceTable = "RGP Out Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("RGP Out No."; Rec."RGP Out No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit();
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Consignee; Rec.Consignee)
                {
                    ApplicationArea = All;
                }
                field("Consignee No."; Rec."Consignee No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        ConsigneeNoOnAfterValidate;
                    end;
                }
                field("Consignee Name"; Rec."Consignee Name")
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field("Consignee City"; Rec."Consignee City")
                {
                    ApplicationArea = All;
                }
                field("Consignee Contact"; Rec."Consignee Contact")
                {
                    ApplicationArea = All;
                }
                field("RGP Date"; Rec."RGP Date")
                {
                    ApplicationArea = All;
                }
                field("Release Status"; Rec."Release Status")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Telex No."; Rec."Telex No.")
                {
                    ApplicationArea = All;
                }
                field("Purchase Order No."; Rec."Purchase Order No.")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                }
                field(Zone; Rec.Zone)
                {
                    ApplicationArea = All;
                }
                field(Division; Rec.Division)
                {
                    ApplicationArea = All;
                }
                field(Station; Rec.Station)
                {
                    ApplicationArea = All;
                }
                field("Sending To"; Rec."Sending To")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Released By"; Rec."Released By")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            part(Control1000000022; "RGP Out Lines")
            {
                SubPageLink = "Document No." = FIELD("RGP Out No.");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Copy Indent")
                {
                    Caption = 'Copy Indent';
                    Image = Indent;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.CopyIndent;
                    end;
                }
                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        RGPRelease.RGPOutRelease(Rec);
                    end;
                }
                action("Re&open")
                {
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        RGPRelease.RGPOutReopen(Rec);
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = Post;
                    ShortCutKey = 'F9';
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        Text050: Label 'There is nothing to post';
                        Text051: Label 'Do you want to post %1?';
                    begin
                        Rec.TESTFIELD("Release Status", Rec."Release Status"::Release);
                        Rec.TESTFIELD("Consignee No.");
                        RGPOutLine.SETRANGE("Document No.", Rec."RGP Out No.");
                        IF NOT RGPOutLine.FINDFIRST THEN
                            ERROR(Text050);
                        IF CONFIRM(Text051, FALSE, Rec."RGP Out No.") THEN BEGIN
                            Rec.PostRGP;
                            CurrPage.UPDATE;
                        END;
                    end;
                }
            }
            action("&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    RGPOutHead.SETRANGE(RGPOutHead."RGP Out No.", Rec."RGP Out No.");
                    REPORT.RUN(50053, TRUE, FALSE, RGPOutHead);
                    RGPOutHead.SETRANGE("RGP Out No.");
                end;
            }
        }
    }

    var
        RGPOutLine: Record "RGP Out Line";
        RGPOutHead: Record "RGP Out Header";
        RGPRelease: Codeunit "RGP Release";

    local procedure ConsigneeNoOnAfterValidate();
    begin
        CurrPage.UPDATE;
    end;
}

