pageextension 70022 BlanketSalesOrdersExt extends 9303
{


    layout
    {

        addafter("Sell-to Customer Name")
        {
            field(Status; Rec.Status)
            {
                ApplicationArea = All;
            }
        }
        addafter("Currency Code")
        {
            field("Payment Terms Code"; Rec."Payment Terms Code")
            {
                ApplicationArea = All;
            }
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;
            }
            field("Customer Posting Group"; Rec."Customer Posting Group")
            {
                ApplicationArea = All;
            }

            /* group(Control1102152003)
             {
                 Editable = false;
                 ShowCaption = false;
                 grid(Control1102152002)
                 {
                     ShowCaption = false;
                     group(Control1102152001)
                     {
                         ShowCaption = false;
                         field("TotalOrders+FORMAT(Rec.COUNT)"; TotalOrders + FORMAT(Rec.COUNT))
                         {
                             Editable = false;
                             ApplicationArea = All;
                         }
                     }
                 }
             }*/
        }
        addbefore(Control1)
        {
            group(Control1102152003)
            {
                Editable = false;
                ShowCaption = false;
                grid(Control1102152002)
                {
                    ShowCaption = false;
                    group(Control1102152001)
                    {
                        ShowCaption = false;
                        field("TotalOrders+FORMAT(Rec.COUNT)"; TotalOrders + FORMAT(Rec.COUNT))
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



        modify(Statistics)
        {
            Promoted = true;
        }



        modify("Make &Order")
        {
            Promoted = true;



        }
        modify(Print)
        {



            Promoted = true;
        }



    }
    var
        UserMgt: Codeunit 5700;
        TotalOrders: Label '"Total Orders: "';




}

