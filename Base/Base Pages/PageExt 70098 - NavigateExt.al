pageextension 70098 NavigateExt extends Navigate
{
    Editable = true;
    layout
    {
        /* modify(Control16)
        {
            ShowCaption = false;
        } */

    }
    actions
    {
        /* modify(Show)
         {
             Promoted = true;
             PromotedIsBig = true;
         }
         modify(Find)
         {
             Promoted = true;
             PromotedIsBig = true;
         }
         modify(Print)
         {
             Promoted = true;
             PromotedIsBig = true;
         }
         modify(FindByDocument)
         {
             Promoted = true;
             PromotedIsBig = true;
         }
         modify(FindByBusinessContact)
         {
             Promoted = true;
             PromotedIsBig = true;
         }
         modify(FindByItemReference)
         {
             Promoted = true;
             PromotedIsBig = true;
         }*/
    }


    var
        QualityItemLedgEntry: Record "Quality Item Ledger Entry";
        QualityLedgEntry: Record "Quality Ledger Entry";
        PostedMaterialIssueHeader: Record "Posted Material Issues Header";



}

