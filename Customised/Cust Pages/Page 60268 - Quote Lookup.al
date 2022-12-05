page 60268 "Quote Lookup"
{
    // version B2BQTO

    PageType = Worksheet;
    SourceTable = "Quote Lookup";

    layout
    {
        area(content)
        {
            field("LookUp Type"; TemplateNameGlobal)
            {
                Caption = 'LookUp Type';
                Editable = false;
                Importance = Promoted;
                ApplicationArea = All;

                trigger OnLookup(Var Text: Text): Boolean;
                begin
                    IF PAGE.RUNMODAL(0, LookUpType) = ACTION::LookupOK THEN BEGIN
                        TemplateNumber := LookUpType.ID;
                        TemplateNameGlobal := LookUpType.Name;
                    END;


                    // For Taxes
                    IF TemplateNumber = 1 THEN BEGIN
                        TaxesColumVisible := TRUE;
                        NotesColumVisible := FALSE;
                        SchedulesColumVisible := FALSE;
                        TermsConditionsColumVisible := FALSE;
                        SpecificationsColumVisible := FALSE;
                    END ELSE
                        TaxesColumVisible := FALSE;
                    //For Notes
                    IF TemplateNumber = 2 THEN BEGIN
                        TaxesColumVisible := FALSE;
                        NotesColumVisible := TRUE;
                        SchedulesColumVisible := FALSE;
                        TermsConditionsColumVisible := FALSE;
                        SpecificationsColumVisible := FALSE;
                    END ELSE
                        NotesColumVisible := FALSE;

                    //Terms & Conditions
                    IF TemplateNumber = 3 THEN BEGIN
                        TaxesColumVisible := FALSE;
                        NotesColumVisible := FALSE;
                        SchedulesColumVisible := FALSE;
                        TermsConditionsColumVisible := TRUE;
                        SpecificationsColumVisible := FALSE;
                    END ELSE
                        TermsConditionsColumVisible := FALSE;

                    //Specifications
                    IF TemplateNumber = 4 THEN BEGIN
                        TaxesColumVisible := FALSE;
                        NotesColumVisible := FALSE;
                        SchedulesColumVisible := FALSE;
                        TermsConditionsColumVisible := FALSE;
                        SpecificationsColumVisible := TRUE;
                    END ELSE
                        SpecificationsColumVisible := FALSE;

                    //Schedules

                    IF TemplateNumber = 5 THEN BEGIN
                        TaxesColumVisible := FALSE;
                        NotesColumVisible := FALSE;
                        SchedulesColumVisible := TRUE;
                        TermsConditionsColumVisible := FALSE;
                        SpecificationsColumVisible := FALSE;
                    END ELSE
                        SchedulesColumVisible := FALSE;

                    // Frieght
                    IF TemplateNumber = 6 THEN BEGIN
                        TaxesColumVisible := FALSE;
                        NotesColumVisible := FALSE;
                        FrieghtColumnsVisible := TRUE;
                        SchedulesColumVisible := FALSE;
                        TermsConditionsColumVisible := FALSE;
                        SpecificationsColumVisible := FALSE;
                    END ELSE
                        FrieghtColumnsVisible := FALSE;

                    // Transit Insurance
                    IF TemplateNumber = 7 THEN BEGIN
                        TaxesColumVisible := FALSE;
                        NotesColumVisible := FALSE;
                        FrieghtColumnsVisible := FALSE;
                        TransitInsurancevisible := TRUE;
                        SchedulesColumVisible := FALSE;
                        TermsConditionsColumVisible := FALSE;
                        SpecificationsColumVisible := FALSE;
                    END ELSE
                        TransitInsurancevisible := FALSE;

                    // delivery of material

                    // Transit Insurance
                    IF TemplateNumber = 8 THEN BEGIN
                        TaxesColumVisible := FALSE;
                        NotesColumVisible := FALSE;
                        FrieghtColumnsVisible := FALSE;
                        TransitInsurancevisible := FALSE;
                        SchedulesColumVisible := FALSE;
                        DeliveryMaterial := TRUE;
                        TermsConditionsColumVisible := FALSE;
                        SpecificationsColumVisible := FALSE;
                    END ELSE
                        DeliveryMaterial := FALSE;

                    // OFFER VALIDITY
                    IF TemplateNumber = 9 THEN BEGIN
                        TaxesColumVisible := FALSE;
                        NotesColumVisible := FALSE;
                        FrieghtColumnsVisible := FALSE;
                        TransitInsurancevisible := FALSE;
                        SchedulesColumVisible := FALSE;
                        DeliveryMaterial := FALSE;
                        OffervalidityVisibility := TRUE;
                        TermsConditionsColumVisible := FALSE;
                        SpecificationsColumVisible := FALSE;
                    END ELSE
                        OffervalidityVisibility := FALSE;

                    //Inspection charges

                    IF TemplateNumber = 10 THEN BEGIN
                        TaxesColumVisible := FALSE;
                        NotesColumVisible := FALSE;
                        FrieghtColumnsVisible := FALSE;
                        TransitInsurancevisible := FALSE;
                        SchedulesColumVisible := FALSE;
                        DeliveryMaterial := FALSE;
                        OffervalidityVisibility := FALSE;
                        InspChargesVisibility := TRUE;
                        TermsConditionsColumVisible := FALSE;
                        SpecificationsColumVisible := FALSE;
                    END ELSE
                        InspChargesVisibility := FALSE;

                    // Special Conditions
                    IF TemplateNumber = 11 THEN BEGIN
                        TaxesColumVisible := FALSE;
                        NotesColumVisible := FALSE;
                        FrieghtColumnsVisible := FALSE;
                        TransitInsurancevisible := FALSE;
                        SchedulesColumVisible := FALSE;
                        DeliveryMaterial := FALSE;
                        OffervalidityVisibility := FALSE;
                        InspChargesVisibility := FALSE;
                        SpecialConditionsVisibility := TRUE;
                        TermsConditionsColumVisible := FALSE;
                        SpecificationsColumVisible := FALSE;
                    END ELSE
                        SpecialConditionsVisibility := FALSE;

                    /*
                    //For ADDITIONS AND DEDUCTIONS
                    IF TemplateNumber = 16 THEN BEGIN
                       SkillsetColumnsVisible := FALSE;
                       AddAndDeduColumnsVisible := TRUE;
                       LoanTypesColumnsVisible := FALSE;
                       PayrollYearsColumnsVisible := FALSE;
                       ComputationTypeColumnsVisible := FALSE;
                       PayCadreColumnsVisible := FALSE;
                       OutStationColumnsVisible := FALSE;
                       OTGroupsColumnsVisible := FALSE;
                       GenaralColumnsVisible := FALSE;
                       PerformanceScaleVisisble := FALSE;
                    END ELSE
                       AddAndDeduColumnsVisible := FALSE;
                    
                    
                    //For LOAN TYPES
                    IF TemplateNumber = 18 THEN BEGIN
                       SkillsetColumnsVisible := FALSE;
                       AddAndDeduColumnsVisible := FALSE;
                       LoanTypesColumnsVisible := TRUE;
                       PayrollYearsColumnsVisible := FALSE;
                       ComputationTypeColumnsVisible := FALSE;
                       PayCadreColumnsVisible := FALSE;
                       OutStationColumnsVisible := FALSE;
                       OTGroupsColumnsVisible := FALSE;
                       GenaralColumnsVisible := FALSE;
                       PerformanceScaleVisisble := FALSE;
                    END ELSE BEGIN
                       LoanTypesColumnsVisible := FALSE;
                    END;
                    
                    
                    //For PAYROLL YEARS
                    IF TemplateNumber = 19 THEN BEGIN
                       SkillsetColumnsVisible := FALSE;
                       AddAndDeduColumnsVisible := FALSE;
                       LoanTypesColumnsVisible := FALSE;
                       PayrollYearsColumnsVisible := TRUE;
                       ComputationTypeColumnsVisible := FALSE;
                       PayCadreColumnsVisible := FALSE;
                       OutStationColumnsVisible := FALSE;
                       OTGroupsColumnsVisible := FALSE;
                       GenaralColumnsVisible := FALSE;
                       PerformanceScaleVisisble := FALSE;
                    END ELSE BEGIN
                      PayrollYearsColumnsVisible := FALSE;
                    END;
                    
                    //For PAYROLL YEARS
                    IF TemplateNumber = 19 THEN BEGIN
                       PayYearVisible := TRUE;
                    END ELSE BEGIN
                       PayYearVisible := FALSE;
                    END;
                    
                    
                    //For COMPUTATION TYPE
                    IF TemplateNumber = 17 THEN BEGIN
                       SkillsetColumnsVisible := FALSE;
                       AddAndDeduColumnsVisible := FALSE;
                       LoanTypesColumnsVisible := FALSE;
                       PayrollYearsColumnsVisible := FALSE;
                       ComputationTypeColumnsVisible := TRUE;
                       PayCadreColumnsVisible := FALSE;
                       OutStationColumnsVisible := FALSE;
                       OTGroupsColumnsVisible := FALSE;
                       GenaralColumnsVisible := FALSE;
                       PerformanceScaleVisisble := FALSE;
                    END ELSE BEGIN
                       ComputationTypeColumnsVisible := FALSE;
                    END;
                    
                    
                    //For PAY CADRE
                    IF TemplateNumber = 20 THEN BEGIN
                       SkillsetColumnsVisible := FALSE;
                       AddAndDeduColumnsVisible := FALSE;
                       LoanTypesColumnsVisible := FALSE;
                       PayrollYearsColumnsVisible := FALSE;
                       ComputationTypeColumnsVisible := FALSE;
                       PayCadreColumnsVisible := TRUE;
                       OutStationColumnsVisible := FALSE;
                       OTGroupsColumnsVisible := FALSE;
                       GenaralColumnsVisible := FALSE;
                       PerformanceScaleVisisble := FALSE;
                    END ELSE BEGIN
                       PayCadreColumnsVisible := FALSE;
                    END;
                    //Scale
                    
                    IF TemplateNumber = 9 THEN BEGIN
                       SkillsetColumnsVisible := FALSE;
                       AddAndDeduColumnsVisible := FALSE;
                       LoanTypesColumnsVisible := FALSE;
                       PayrollYearsColumnsVisible := FALSE;
                       ComputationTypeColumnsVisible := FALSE;
                       PayCadreColumnsVisible := FALSE;
                       OutStationColumnsVisible := FALSE;
                       OTGroupsColumnsVisible := FALSE;
                       GenaralColumnsVisible := FALSE;
                       PerformanceScaleVisisble := TRUE;
                    END ELSE BEGIN
                       PerformanceScaleVisisble := FALSE;
                    END;
                    
                    
                    //For PAY CADRE
                    //Paycadrepayelents
                    IF TemplateNumber = 20 THEN BEGIN
                       DefinePayEleVisisble := TRUE;
                    END ELSE BEGIN
                       DefinePayEleVisisble := FALSE;
                    END;
                    
                    // Code Commeted as these lookups are not system defined
                    {
                    IF TemplateNameGlobal = 'OUT STATION ALLOWANCE' THEN BEGIN
                       SkillsetColumnsVisible := FALSE;
                       AddAndDeduColumnsVisible := FALSE;
                       LoanTypesColumnsVisible := FALSE;
                       PayrollYearsColumnsVisible := FALSE;
                       ComputationTypeColumnsVisible := FALSE;
                       PayCadreColumnsVisible := FALSE;
                       OutStationColumnsVisible := TRUE;
                       OTGroupsColumnsVisible := FALSE;
                       GenaralColumnsVisible := FALSE;
                    END ELSE BEGIN
                       OutStationColumnsVisible := FALSE;
                    END;
                    
                    IF TemplateNameGlobal = 'OT GROUPS' THEN BEGIN
                       SkillsetColumnsVisible := FALSE;
                       AddAndDeduColumnsVisible := FALSE;
                       LoanTypesColumnsVisible := FALSE;
                       PayrollYearsColumnsVisible := FALSE;
                       ComputationTypeColumnsVisible := FALSE;
                       PayCadreColumnsVisible := FALSE;
                       OutStationColumnsVisible := FALSE;
                       OTGroupsColumnsVisible := TRUE;
                       GenaralColumnsVisible := FALSE;
                    END ELSE BEGIN
                       OTGroupsColumnsVisible := FALSE;
                    END;
                    }
                    
                    
                    //For PayCadre,Compuation Type,Payrol Years,Loan Types,Additions & Deductions,Skill Set
                    IF NOT (TemplateNumber IN[20,17,19,18,16,1,9]) THEN BEGIN
                       SkillsetColumnsVisible := FALSE;
                       AddAndDeduColumnsVisible := FALSE;
                       LoanTypesColumnsVisible := FALSE;
                       PayrollYearsColumnsVisible := FALSE;
                       ComputationTypeColumnsVisible := FALSE;
                       PayCadreColumnsVisible := FALSE;
                       OutStationColumnsVisible := FALSE;
                       OTGroupsColumnsVisible := FALSE;
                       GenaralColumnsVisible := TRUE;
                       PerformanceScaleVisisble := FALSE;
                    END ELSE BEGIN
                       GenaralColumnsVisible := FALSE;
                    END;
                    
                    */

                    Rec.SETRANGE("Lookup Type ID", TemplateNumber);
                    CurrPage.UPDATE(FALSE);

                end;
            }
            repeater(Taxes)
            {
                Caption = 'Taxes';
                Visible = TaxesColumVisible;
                field("Lookup Code"; Rec."Lookup Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        Rec."Lookup Type ID" := TemplateNumber;
                    end;
                }
                field("Lookup Type ID"; Rec."Lookup Type ID")
                {
                    ApplicationArea = All;
                }
                field("Lookup Type Name"; Rec."Lookup Type Name")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Select; Rec.Select)
                {
                    ApplicationArea = All;
                }
            }
            repeater(Notes)
            {
                Caption = 'Notes';
                Visible = NotesColumVisible;
                field("Notes Lookup Code"; Rec."Lookup Code")
                {
                    Caption = 'Notes Lookup Code';
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        Rec."Lookup Type ID" := TemplateNumber;
                    end;
                }
                field("Notes Lookup Type ID"; Rec."Lookup Type ID")
                {
                    Caption = 'Notes Lookup Type ID';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Notes Lookup Type Name"; Rec."Lookup Type Name")
                {
                    Caption = 'Notes Lookup Type Name';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Notes Description"; Rec.Description)
                {
                    Caption = 'Notes Description';
                    ApplicationArea = All;
                }
                field("Notes Select"; Rec.Select)
                {
                    Caption = 'Notes Select';
                    ApplicationArea = All;
                }
            }
            repeater("Terms & Conditions")
            {
                Caption = 'Terms & Conditions';
                Visible = TermsConditionsColumVisible;
                field("T&C Lookup Code"; Rec."Lookup Code")
                {
                    Caption = 'T&C Lookup Code';
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        Rec."Lookup Type ID" := TemplateNumber;
                    end;
                }
                field("T&C Lookup Type ID"; Rec."Lookup Type ID")
                {
                    Caption = '" T&C Lookup Type ID"';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("T&C Lookup Type Name"; Rec."Lookup Type Name")
                {
                    Caption = 'T&C Lookup Type Name';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("T&C Description"; Rec.Description)
                {
                    Caption = 'T&C Description';
                    ApplicationArea = All;
                }
                field("T&C Select"; Rec.Select)
                {
                    Caption = 'T&C Select';
                    ApplicationArea = All;
                }
                field("Terms LookUp"; Rec."Terms LookUp")
                {
                    ApplicationArea = All;
                }
            }
            repeater(Specifications)
            {
                Caption = 'Specifications';
                Visible = SpecificationsColumVisible;
                field("Spe Lookup Code"; Rec."Lookup Code")
                {
                    Caption = 'Spe Lookup Code';
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        Rec."Lookup Type ID" := TemplateNumber;
                    end;
                }
                field("Spe Lookup Type ID"; Rec."Lookup Type ID")
                {
                    Caption = 'Spe Lookup Type ID';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Spe Lookup Type Name"; Rec."Lookup Type Name")
                {
                    Caption = 'Spe Lookup Type Name';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Spe Description"; Rec.Description)
                {
                    Caption = 'Spe Description';
                    ApplicationArea = All;
                }
                field("Spec Select"; Rec.Select)
                {
                    Caption = 'Spec Select';
                    ApplicationArea = All;
                }
            }
            repeater(Schedules)
            {
                Caption = 'Schedules';
                Visible = SchedulesColumVisible;
                field("Schedule LookUp"; Rec."Schedule LookUp")
                {
                    ApplicationArea = All;
                }
                field("Sch Lookup Code"; Rec."Lookup Code")
                {
                    Caption = 'Sch Lookup Code';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        Rec."Lookup Type ID" := TemplateNumber;
                    end;
                }
                field("Sch Lookup Type ID"; Rec."Lookup Type ID")
                {
                    Caption = 'Sch Lookup Type ID';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Sch Lookup Type Name"; Rec."Lookup Type Name")
                {
                    Caption = 'Sch Lookup Type Name';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Sch Description"; Rec.Description)
                {
                    Caption = 'Sch Description';
                    ApplicationArea = All;
                }
                field("Sch Select"; Rec.Select)
                {
                    Caption = 'Sch Select';
                    ApplicationArea = All;
                }
                field(FieldNo1; Rec.FieldNo1)
                {
                    Caption = 'FieldNo1';
                    ApplicationArea = All;
                }
                field(FieldNo2; Rec.FieldNo2)
                {
                    Caption = 'FieldNo2';
                    ApplicationArea = All;
                }
                field(FieldNo3; Rec.FieldNo3)
                {
                    Caption = 'FieldNo3';
                    ApplicationArea = All;
                }
                field(FieldNo4; Rec.FieldNo4)
                {
                    Caption = 'FieldNo4';
                    ApplicationArea = All;
                }
                field(FieldNo5; Rec.FieldNo5)
                {
                    Caption = 'FieldNo5';
                    ApplicationArea = All;
                }
                field(FieldNo6; Rec.FieldNo6)
                {
                    Caption = 'FieldNo6';
                    ApplicationArea = All;
                }
                field(Qty; Rec.Qty)
                {
                    Caption = 'Qty';
                    ApplicationArea = All;
                }
                field(Rate; Rec.Rate)
                {
                    Caption = 'Rate';
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Amount';
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    Caption = 'Remarks';
                    ApplicationArea = All;
                }
            }
            repeater(FREIGHT)
            {
                Caption = 'FREIGHT';
                Visible = FrieghtColumnsVisible;
                field("Frieght Lookup Code"; Rec."Lookup Code")
                {
                    Caption = 'Frieght Lookup Code';
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        Rec."Lookup Type ID" := TemplateNumber;
                    end;
                }
                field("Frieght Lookup Type ID"; Rec."Lookup Type ID")
                {
                    Caption = 'Frieght Lookup Type ID';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Frieght Lookup Type Name"; Rec."Lookup Type Name")
                {
                    Caption = 'Frieght Lookup Type Name';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Frieght Description"; Rec.Description)
                {
                    Caption = 'Frieght Description';
                    ApplicationArea = All;
                }
                field("Frieght Select"; Rec.Select)
                {
                    Caption = 'Frieght Select';
                    ApplicationArea = All;
                }
            }
            repeater("Transit Insurance")
            {
                Caption = 'Transit Insurance';
                Visible = TransitInsurancevisible;
                field("Transit Insurance  Lookup Code"; Rec."Lookup Code")
                {
                    Caption = 'Transit Insurance Lookup Code';
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        Rec."Lookup Type ID" := TemplateNumber;
                    end;
                }
                field("Transit Insurance Lookup Type ID"; Rec."Lookup Type ID")
                {
                    Caption = 'Transit Insurance Lookup Type ID';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Transit Insurance Type Name"; Rec."Lookup Type Name")
                {
                    Caption = 'Transit Insurance Type Name';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Transit Insurance  Description"; Rec.Description)
                {
                    Caption = 'Transit Insurance  Description';
                    ApplicationArea = All;
                }
                field("Transit Insurance Select"; Rec.Select)
                {
                    Caption = 'Transit Insurance Select';
                    ApplicationArea = All;
                }
            }
            repeater("DELIVERY OF MATERIAL")
            {
                Caption = 'DELIVERY OF MATERIAL';
                Visible = DeliveryMaterial;
                field("Delivery Material Lookup Code"; Rec."Lookup Code")
                {
                    Caption = 'Delivery Material Lookup Code';
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        Rec."Lookup Type ID" := TemplateNumber;
                    end;
                }
                field("Delivery Material Lookup Type ID"; Rec."Lookup Type ID")
                {
                    Caption = 'Delivery Material Lookup Type ID';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Delivery Material Type Name"; Rec."Lookup Type Name")
                {
                    Caption = 'Delivery Material Type Name';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Delivery Material Description"; Rec.Description)
                {
                    Caption = 'Delivery Material Description';
                    ApplicationArea = All;
                }
                field("Delivery Material Select"; Rec.Select)
                {
                    Caption = 'Delivery Material Select';
                    ApplicationArea = All;
                }
            }
            repeater("OFFER VALIDITY")
            {
                Caption = 'OFFER VALIDITY';
                Visible = OffervalidityVisibility;
                field("Offer Validity Lookup Code"; Rec."Lookup Code")
                {
                    Caption = 'Offer Validity Lookup Code';
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        Rec."Lookup Type ID" := TemplateNumber;
                    end;
                }
                field("Offer Validity Lookup Type ID"; Rec."Lookup Type ID")
                {
                    Caption = 'Offer Validity Lookup Type ID';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Offer Validity Type Name"; Rec."Lookup Type Name")
                {
                    Caption = 'Offer Validity Type Name';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Offer Validity Description"; Rec.Description)
                {
                    Caption = 'Offer Validity Description';
                    ApplicationArea = All;
                }
                field("Offer Validity Select"; Rec.Select)
                {
                    Caption = 'Offer Validity Select';
                    ApplicationArea = All;
                }
            }
            repeater("Inspection Charges")
            {
                Caption = 'Inspection Charges';
                Visible = InspChargesVisibility;
                field("Inspection Charges Lookup Code"; Rec."Lookup Code")
                {
                    Caption = 'Inspection Charges Lookup Code';
                    Visible = true;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        Rec."Lookup Type ID" := TemplateNumber;
                    end;
                }
                field("Insp Chrages Lookup Type ID"; Rec."Lookup Type ID")
                {
                    Caption = 'Insp Chrages Lookup Type ID';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Insp Charges Type Name"; Rec."Lookup Type Name")
                {
                    Caption = 'Insp Charges Type Name';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Insp Charges Description"; Rec.Description)
                {
                    Caption = 'Insp Charges Description';
                    ApplicationArea = All;
                }
                field("Insp Charges  Select"; Rec.Select)
                {
                    Caption = 'Insp Charges Select';
                    ApplicationArea = All;
                }
            }
            repeater("Special Conditions")
            {
                Caption = 'Special Conditions';
                Visible = SpecialConditionsVisibility;
                field("Special Condition Lookup Code"; Rec."Lookup Code")
                {
                    Caption = 'Special Condition Lookup Code';
                    Visible = true;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        Rec."Lookup Type ID" := TemplateNumber;
                    end;
                }
                field("Special Condition Lookup Type ID"; Rec."Lookup Type ID")
                {
                    Caption = 'Special Condition Lookup Type ID';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Special Condition Type Name"; Rec."Lookup Type Name")
                {
                    Caption = 'Special Condition Type Name';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Special Condition Description"; Rec.Description)
                {
                    Caption = 'Special Condition Description';
                    ApplicationArea = All;
                }
                field("Special Condition  Select"; Rec.Select)
                {
                    Caption = 'Special Condition  Select';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Action1102152028)
            {
                action(QuoteSpecification)
                {
                    Caption = 'Quote Specification';
                    Image = ShowWarning;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    //RunObject = Page Page70003; //B2BUPG Same issue in nav 2016 itself.
                    //RunPageLink = Field1 = FIELD("Lookup Code");
                    Visible = SpecificationsColumVisible;
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    begin
        Rec."Lookup Type ID" := TemplateNumber;
    end;

    trigger OnOpenPage();
    begin
        //Setting the Initial Values when the page is loaded to LookupTypes.
        TemplateNumber := 1;
        TemplateNameGlobal := 'Taxes';
        Rec.SETRANGE("Lookup Type ID", 1);
        TaxesColumVisible := TRUE;
        NotesColumVisible := FALSE;
        SchedulesColumVisible := FALSE;
        TermsConditionsColumVisible := FALSE;
        SpecificationsColumVisible := FALSE;
    end;

    var
        TemplateNameGlobal: Code[50];
        TemplateNumber: Integer;
        LookUpType: Record "Quote LookUp Type";
        Lookup: Record "Quote Lookup";
        TaxesColumVisible: Boolean;
        NotesColumVisible: Boolean;
        TermsConditionsColumVisible: Boolean;
        SpecificationsColumVisible: Boolean;
        SchedulesColumVisible: Boolean;
        SchecVisible: Boolean;
        FrieghtColumnsVisible: Boolean;
        TransitInsurancevisible: Boolean;
        DeliveryMaterial: Boolean;
        OffervalidityVisibility: Boolean;
        InspChargesVisibility: Boolean;
        SpecialConditionsVisibility: Boolean;
}

