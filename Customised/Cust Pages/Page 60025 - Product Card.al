page 60025 "Product Card"
{
    // version B2B1.0,Rev01

    PageType = Card;
    SourceTable = Products;

    layout
    {
        area(content)
        {
            group(Products)
            {
                Caption = 'Products';
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field("Product Type"; Rec."Product Type")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Technology; Rec.Technology)
                {
                    ApplicationArea = All;
                }
                field("Key Features"; Rec."Key Features")
                {
                    ApplicationArea = All;
                }
                field("Launched Year"; Rec."Launched Year")
                {
                    ApplicationArea = All;
                }
                field("Tools Used"; Rec."Tools Used")
                {
                    ApplicationArea = All;
                }
                field(Benefits; Rec.Benefits)
                {
                    ApplicationArea = All;
                }
                field(Segment; Rec.Segment)
                {
                    ApplicationArea = All;
                }
                field(Price; Rec.Price)
                {
                    ApplicationArea = All;
                }
                field("Software Code"; Rec."Software Code")
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
            group("&Products")
            {
                Caption = '&Products';
                separator(Action1102152026)
                {
                }
                action("&Comments")
                {
                    Caption = '&Comments';
                    RunObject = Page 5072;
                    RunPageLink = "Table Name" = CONST(Products), "No." = FIELD(Code);
                    ApplicationArea = All;
                }
                separator(Action1102152030)
                {
                }
                action("&Attachments")
                {
                    Caption = '&Attachments';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        OpenAttachments;
                    end;
                }
            }
            group("&Details")
            {
                Caption = '&Details';
                action("Product C&ompetitors")
                {
                    Caption = 'Product C&ompetitors';
                    RunObject = Page "Product Competitors Details";
                    RunPageLink = "Product Code" = FIELD(Code);
                    ApplicationArea = All;
                }
                separator(Action1102152023)
                {
                }
                action("Product C&ustomers List")
                {
                    Caption = 'Product C&ustomers List';
                    RunObject = Page "Product Customer's list";
                    RunPageLink = "SMTP Server name" = FIELD(Code);
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        SalesShipmentLine: Record "Sales Shipment Line";
                        Customer: Record Customer;
                        CustomerList: Record "SMTP SETUP";
                        CustomerList1: Record "SMTP SETUP";
                    begin
                        SalesShipmentLine.SETRANGE(SalesShipmentLine."No.", Code);
                        IF SalesShipmentLine.FINDSET THEN
                            REPEAT
                                Customer.SETRANGE("No.", SalesShipmentLine."Sell-to Customer No.");
                                IF Customer.FINDFIRST THEN;
                            UNTIL SalesShipmentLine.NEXT = 0;
                    end;
                }
            }
        }
        area(processing)
        {
            action(Comment)
            {
                Caption = 'Comment';
                Image = Comment;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 5072;
                RunPageLink = "Table Name" = CONST(Products), "No." = FIELD(Code);
                ToolTip = 'Comment';
                ApplicationArea = All;
            }
        }
    }
}

