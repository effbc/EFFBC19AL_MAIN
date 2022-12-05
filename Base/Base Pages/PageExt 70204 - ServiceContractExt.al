pageextension 70204 ServiceContractExt extends "Service Contract"
{

    layout
    {


        modify("Post Code")
        {



            CaptionML = ENU = 'Post Code/City';


        }


        modify("Bill-to City")
        {


            CaptionML = ENU = 'Bill-to Post Code/City';


        }


        modify("Ship-to Post Code")
        {


            CaptionML = ENU = 'Ship-to Post Code/City';


        }


        modify("Service Period")
        {


            CaptionML = ENU = 'Prev.Maintainence Visits';


        }


    }
    actions
    {



        modify("Action178")
        {


            Promoted = true;


        }



        modify("&Print")
        {



            Promoted = true;


        }


        modify(CreateServiceInvoice)
        {
            Promoted = true;
        }


        modify(LockContract)
        {
            Promoted = true;
        }


        modify(SignContract)
        {
            Promoted = true;
        }


        modify("Copy &Document...")
        {
            Promoted = true;


        }



        modify("Contract Details")
        {


            Promoted = true;


        }
        modify("Contract Gain/Loss Entries")
        {


            Promoted = true;



        }
        modify("Contract Invoicing")
        {



            Promoted = true;


        }
        modify("Contract Price Update - Test")
        {



            Promoted = false;



        }
        modify("Prepaid Contract")
        {



            Promoted = false;


        }
        modify("Expired Contract Lines")
        {



            Promoted = true;


        }
    }




    local procedure NextInvoicePeriodOnFormat(Text: Text[1024]);
    begin
        Text := Rec.NextInvoicePeriod;
    end;


}

