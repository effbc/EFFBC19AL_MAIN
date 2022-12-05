page 60246 "Effe Hyd Excise Entries"
{
    // version NAVIN7.00

    // <changelog>
    //     <change releaseversion="IN6.00.01"/>
    // <change id="PS35990" dev="suneethg" date="2009-04-25" area="Excise" releaseversion="IN6.00.01" feature="35990"
    // >Caption ML has been changed excise amount to amount.</change>
    // </changelog>

    /*
    CaptionML = ENU = 'Excise Entries',
                ENN = 'Excise Entries';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    Permissions = TableData "Excise Entry" = rimd;
    SourceTable = "Excise Entry";
    SourceTableView = WHERE("Document No." = FILTER(PTS*|TO*),Type=FILTER(Sale));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Item No."; "Item No.")
                {
                }
                field("Entry No."; "Entry No.")
                {
                }
                field("Posting Date"; "Posting Date")
                {
                }
                field("External Document No."; "External Document No.")
                {
                }
                field("Document No."; "Document No.")
                {
                }
                field("Document Type"; "Document Type")
                {
                }
                field(Type; Type)
                {
                }
                field("E.C.C. No."; "E.C.C. No.")
                {
                }
                field(Base; Base)
                {
                }
                field("BED %"; "BED %")
                {
                }
                field("ADC VAT Amount"; "ADC VAT Amount")
                {
                    Visible = false;
                }
                field("BED Amount"; "BED Amount")
                {
                    Editable = true;
                }
                field("SED Amount"; "SED Amount")
                {
                    Visible = false;
                }
                field("AED(GSI) Amount"; "AED(GSI) Amount")
                {
                    Visible = false;
                }
                field("NCCD Amount"; "NCCD Amount")
                {
                    Visible = false;
                }
                field("AED(TTA) Amount"; "AED(TTA) Amount")
                {
                    Visible = false;
                }
                field("SAED Amount"; "SAED Amount")
                {
                    Visible = false;
                }
                field("ADE Amount"; "ADE Amount")
                {
                    Visible = false;
                }
                field("ADET Amount"; "ADET Amount")
                {
                    Visible = false;
                }
                field("CESS Amount"; "CESS Amount")
                {
                    Visible = false;
                }
                field("eCess %"; "eCess %")
                {
                }
                field("eCess Amount"; "eCess Amount")
                {
                }
                field("SHE Cess %"; "SHE Cess %")
                {
                }
                field("SHE Cess Amount"; "SHE Cess Amount")
                {
                }
                field("Excise Bus. Posting Group"; "Excise Bus. Posting Group")
                {
                }
                field("Excise Prod. Posting Group"; "Excise Prod. Posting Group")
                {
                }
                field("Sell-to/Buy-from No."; "Sell-to/Buy-from No.")
                {
                }
                field(CVD; CVD)
                {
                    Editable = false;
                }
                field(Amount; Amount)
                {
                }
                field(Deferred; Deferred)
                {
                }
                field("AED(GSI) Calculation Type"; "AED(GSI) Calculation Type")
                {
                    Visible = false;
                }
                field("AED(GSI) %"; "AED(GSI) %")
                {
                    Visible = false;
                }
                field("SED Calculation Type"; "SED Calculation Type")
                {
                    Visible = false;
                }
                field("SED %"; "SED %")
                {
                    Visible = false;
                }
                field("SAED Calculation Type"; "SAED Calculation Type")
                {
                    Visible = false;
                }
                field("SAED %"; "SAED %")
                {
                    Visible = false;
                }
                field("CESS Calculation Type"; "CESS Calculation Type")
                {
                    Visible = false;
                }
                field("CESS %"; "CESS %")
                {
                    Visible = false;
                }
                field("NCCD Calculation Type"; "NCCD Calculation Type")
                {
                    Visible = false;
                }
                field("NCCD %"; "NCCD %")
                {
                    Visible = false;
                }
                field("eCess Calculation Type"; "eCess Calculation Type")
                {
                }
                field("AED(TTA) Calculation Type"; "AED(TTA) Calculation Type")
                {
                    Visible = false;
                }
                field("AED(TTA) %"; "AED(TTA) %")
                {
                    Visible = false;
                }
                field("ADET Calculation Type"; "ADET Calculation Type")
                {
                    Visible = false;
                }
                field("ADET %"; "ADET %")
                {
                    Visible = false;
                }
                field("ADE Calculation Type"; "ADE Calculation Type")
                {
                    Visible = false;
                }
                field("ADE %"; "ADE %")
                {
                    Visible = false;
                }
                field("SHE Cess Calculation Type"; "SHE Cess Calculation Type")
                {
                }
                field("ADC VAT Calculation Type"; "ADC VAT Calculation Type")
                {
                    Visible = false;
                }
                field("ADC VAT %"; "ADC VAT %")
                {
                    Visible = false;
                }
                field(SSI; SSI)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Navigate")
            {
                CaptionML = ENU = '&Navigate',
                            ENN = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction();
                begin
                    Navigate.SetDoc("Posting Date", "Document No.");
                    Navigate.RUN;
                end;
            }
        }
    }

    var
        Navigate: Page 344;
        */
}

