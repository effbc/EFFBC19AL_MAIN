page 33000291 "Specificatinn Version"
{
    // version QC1.0,Rev01

    PageType = Document;
    SourceTable = "Specification Version";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Version Code"; Rec."Version Code")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit();
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = All;
                }
            }
            part(Control1102152012; "Specification Subform")
            {
                SubPageLink = "Spec ID" = FIELD("Specification No."), "Version Code" = FIELD("Version Code");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctons")
            {
                Caption = 'F&unctons';
                Image = "Action";
                action("Copy Specification Header")
                {
                    Caption = 'Copy Specification Header';
                    Image = CopyDocument;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        IF NOT CONFIRM(Text000, FALSE) THEN
                            EXIT;

                        SpecHeader.GET(Rec."Specification No.");
                        SpecCopy.CopySpec(Rec."Specification No.", '', SpecHeader, Rec."Version Code");
                    end;
                }
                action("Copy Specification Version")
                {
                    Caption = 'Copy Specification Version';
                    Image = CopyRouteVersion;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        SpecCopy.CopyFromVersion(Rec);
                    end;
                }
                action(Indent)
                {
                    Caption = 'Indent';
                    Image = Indent;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        SpecIndent.IndentSpecVersion(Rec);
                    end;
                }
            }
        }
    }

    var
        SpecIndent: Codeunit "Spec Line-Indent";
        Text000: Label 'Copy from Specification?';
        SpecHeader: Record "Specification Header";
        SpecCopy: Codeunit "Specification-Copy";
}

