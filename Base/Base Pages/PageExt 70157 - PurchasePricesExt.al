pageextension 70157 PurchasePricesExt extends 7012
{

    layout
    {


        /*modify("Control1")
        {

          

            ShowCaption = false;
        }*/
        addafter(VendNoFilterCtrl)
        {
            field(VendorNameFilter; VendorNameFilter)
            {
                trigger OnValidate()
                begin
                    VendorNameFilterOnAfterValidate;
                end;
            }
        }


        addafter("Ending Date")
        {
            field("Maximum Quantity"; Rec."Maximum Quantity")
            {
                ApplicationArea = All;
            }
            field(Make; Rec.Make)
            {
                ApplicationArea = All;
            }
            field("Part Number"; Rec."Part Number")
            {
                ApplicationArea = All;
            }
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;
            }
            field("Vendor Name"; "Vendor Name")
            {
                ApplicationArea = All;
            }
            field("Lead Time";"Lead Time")
            {
                ApplicationArea = All;
            }

        }
        modify("Vendor No.")
        {
            trigger OnAfterValidate()
            var
                Vend: Record Vendor;
            begin
                Vend.RESET;
                Vend.SETFILTER(Vend."No.", "Vendor No.");
                IF Vend.FINDFIRST THEN
                    "Vendor Name" := Vend.Name;
            end;
        }
        modify("Item No.")
        {
            trigger OnAfterValidate()
            var
                item: Record Item;
            begin
                item.RESET;
                item.SETFILTER(item."No.", "Item No.");
                IF item.FINDFIRST THEN
                    "Item Description" := item.Description;
            end;
        }
    }
    actions
    {



    }

    var
        VendorNameFilter: Text;
        item: record Item;

    LOCAL PROCEDURE VendorNameFilterOnAfterValidate();
    BEGIN
        IF item.GET("Item No.") THEN
            CurrPage.SAVERECORD;
        SetRecFilters;
    END;


}

