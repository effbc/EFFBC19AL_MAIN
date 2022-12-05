codeunit 80007 "Master Validate"
{
    // The following Masters were covered under this Code Unit:
    // 
    // 1Location - Validated - Done
    // 2G/L Account- Validated
    // 3Customer - Validated - Done
    // 4Vendor   - Validated - Done
    // 5Item     - Validated - Done
    // 6Resource Group- Validated - Done
    // 7Resource- Validated       - Done
    // 8Unit of Measure - Validated - Done
    // 9Resource Unit of Measure- Validated - Done
    // 10Item Unit of Measure  - Validated - Done
    // 11Bank Account- Validated           - Done
    // 12Dimension- Validated              - Done
    // 13Dimension Value- Validated        - Done
    // 14Dimension Combination- Validated  - Done
    // 15Dimension Value Combination- Validated  - Done
    // 16Default Dimension- Validated            - Done
    // 17Employee- Validated
    // 18Fixed Asset- Validated               - Done
    // 19Depreciation Book- Validated
    // 20FA Depreciation Book- Validated
    // 21Service Item- Validated            - Done
    // 22Work Center  - Validated           - Done
    // 23Routing Header
    // 24Routing Line
    // 25Production BOM Header              - Done
    // 26Production BOM Line                - Done
    // 27Main Asset Component
    // 28Currency       - Validated
    // 29 Machine Centre - Validated         - Done


    trigger OnRun();
    begin
        Window.OPEN('FIle Name #1#####################################\' + 'Record    #2#####################################'
                    , FIleName, RecordNo);

        /*
        //Validate Location
        IF Location.FINDSET THEN BEGIN
         FIleName:='location';
         REPEAT
         RecordNo:=Location.Code;
         Window.UPDATE();
         Location.VALIDATE(Location."Use As In-Transit");
         Location.VALIDATE(Location."Put-away Template Code");
         Location.VALIDATE(Location."Purch. Invoice Nos.");
         Location.VALIDATE(Location."Purch. Receipt Nos.");
         Location.VALIDATE(Location."Sales Invoice Nos.");
         Location.VALIDATE(Location."Sales Shipment Nos.");
         //Location.VALIDATE(Location.Bonded);
         Location.VALIDATE(Location."Excise Bus. Posting Group");
         Location.VALIDATE(Location."E.C.C. No.");
         Location.VALIDATE(Location."C.E. Regd No.");
         Location.VALIDATE(Location."C.E. Range");
         Location.VALIDATE(Location."C.E. Commissionerate");
         Location.VALIDATE(Location."C.E. Division");
         Location.VALIDATE(Location.State);
         Location.VALIDATE(Location."Subcontracting Location");
         Location.VALIDATE(Location."Subcontractor No.");
         Location.MODIFY(TRUE);
         UNTIL Location.NEXT=0;
         END;
          */
        /*
     //Validate COA
     IF COA.FINDFIRST THEN BEGIN
      FIleName:='COA';
      REPEAT
      RecordNo:=COA."No.";
      Window.UPDATE(2,COA."No.");
      COA.VALIDATE(COA."No.");
      COA.VALIDATE(COA."Account Type");
      COA.VALIDATE(COA."Global Dimension 1 Code");
      COA.VALIDATE(COA."Global Dimension 2 Code");
      COA.VALIDATE(COA."Income/Balance");
      COA.VALIDATE(COA."Debit/Credit");
      COA.VALIDATE(COA.Blocked);
      COA.VALIDATE(COA."Direct Posting");
      COA.VALIDATE(COA."Reconciliation Account");
      COA.VALIDATE(COA.Indentation);
      COA.VALIDATE(COA."Tax Area Code");
      COA.VALIDATE(COA."Tax Liable");
      COA.VALIDATE(COA."Tax Group Code");
      COA.VALIDATE(COA."VAT Bus. Posting Group");
      COA.VALIDATE(COA."VAT Prod. Posting Group");
      COA.VALIDATE(COA."Exchange Rate Adjustment");
      COA.MODIFY(TRUE);
      UNTIL COA.NEXT=0;
      END;
       */
        /*
        //Customer Validate
      IF Customer.FINDFIRST THEN BEGIN
       FIleName:='Customer';
       REPEAT
       RecordNo:=Customer."No.";
       Window.UPDATE(2,Customer."No.");
       Customer.VALIDATE(Customer."No.");
       Customer.VALIDATE(Customer.Contact);
       Customer.VALIDATE(Customer."Our Account No.");
       Customer.VALIDATE(Customer."Global Dimension 1 Code");
       Customer.VALIDATE( Customer."Global Dimension 2 Code");
       Customer.VALIDATE(Customer."Customer Posting Group");
       Customer.VALIDATE(Customer."Customer Price Group");
       Customer.VALIDATE(Customer."Language Code");
       Customer.VALIDATE(Customer."Statistics Group");
       Customer.VALIDATE(Customer."Payment Terms Code");
       Customer.VALIDATE(Customer."Fin. Charge Terms Code");
       Customer.VALIDATE(Customer."Salesperson Code");
       Customer.VALIDATE(Customer."Shipment Method Code");
       Customer.VALIDATE(Customer."Shipping Agent Code");
       Customer.VALIDATE(Customer."Place of Export");
       Customer.VALIDATE(Customer."Invoice Disc. Code");
       Customer.VALIDATE(Customer."Customer Disc. Group");
       Customer.VALIDATE(Customer."Country Code");
       Customer.VALIDATE(Customer."Collection Method");
       Customer.VALIDATE(Customer.Blocked);
       Customer.VALIDATE(Customer."Bill-to Customer No.");
       Customer.VALIDATE(Customer."Application Method");
       Customer.VALIDATE(Customer."Location Code");
       Customer.VALIDATE(Customer."Gen. Bus. Posting Group");
       Customer.VALIDATE(Customer."No. Series");
       Customer.VALIDATE(Customer."Tax Area Code");
       Customer.VALIDATE(Customer."Tax Liable");
       Customer.VALIDATE(Customer."VAT Bus. Posting Group");
       Customer.VALIDATE(Customer."Primary Contact No.");
       Customer.VALIDATE(Customer."Responsibility Center");
       Customer.VALIDATE(Customer."Shipping Agent Service Code");
       Customer.VALIDATE(Customer."Service Zone Code");
       Customer.VALIDATE(Customer."Notification Process Code");
       Customer.VALIDATE(Customer."Queue Priority");
       Customer.VALIDATE(Customer."Allow Line Disc.");
       Customer.VALIDATE(Customer."Base Calendar Code");
       Customer.VALIDATE(Customer."T.I.N. No.");
       Customer.VALIDATE(Customer."Tax Exemption No.");
       Customer.VALIDATE(Customer."Party's L.S.T No.");
       Customer.VALIDATE(Customer."Party's C.S.T No.");
       Customer.VALIDATE(Customer."P.A.N No.");
       Customer.VALIDATE(Customer."E.C.C No.");
       Customer.VALIDATE(Customer.Range);
       Customer.VALIDATE(Customer."Excise Bus. Posting Group");
       Customer.VALIDATE(Customer."Excise Registration No.");
       Customer.VALIDATE(Customer."Banker Name & Address");
       Customer.VALIDATE(Customer."SSI No.");
       Customer.VALIDATE(Customer.State);
      // Customer.VALIDATE(Customer.SSI);
       Customer.VALIDATE(Customer."SSI Validity Date");
       Customer.VALIDATE(Customer.Structure);
       Customer.VALIDATE(Customer."VAT Business Posting Group");
       Customer.VALIDATE(Customer."Free Trade Zone");
       Customer.MODIFY(TRUE);
       UNTIL Customer.NEXT=0;
       END;
        */
        /*
      //Vendor Validate
      IF Vendor.FINDFIRST THEN BEGIN
       FIleName:='Vendor';
       REPEAT
       RecordNo:=Vendor."No.";
       Window.UPDATE();
       Vendor.VALIDATE(Vendor."No.");
       Vendor.VALIDATE(Vendor.Contact);
       Vendor.VALIDATE(Vendor."Our Account No.");
       Vendor.VALIDATE(Vendor."Global Dimension 1 Code");
       Vendor.VALIDATE(Vendor."Global Dimension 2 Code");
       Vendor.VALIDATE(Vendor."Vendor Posting Group");
       Vendor.VALIDATE(Vendor."Currency Code");
       Vendor.VALIDATE(Vendor."Language Code");
       Vendor.VALIDATE(Vendor."Statistics Group");
       Vendor.VALIDATE(Vendor."Payment Terms Code");
       Vendor.VALIDATE(Vendor."Fin. Charge Terms Code");
       Vendor.VALIDATE(Vendor."Purchaser Code");
       Vendor.VALIDATE(Vendor."Shipment Method Code");
       Vendor.VALIDATE(Vendor."Shipping Agent Code");
       Vendor.VALIDATE(Vendor."Invoice Disc. Code");
       Vendor.VALIDATE(Vendor."Country Code");
       Vendor.VALIDATE(Vendor.Blocked);
       Vendor.VALIDATE(Vendor."Pay-to Vendor No.");
       Vendor.VALIDATE(Vendor."Payment Method Code");
       Vendor.VALIDATE(Vendor."Application Method");
       Vendor.VALIDATE(Vendor."VAT Registration No.");
       Vendor.VALIDATE(Vendor."Gen. Bus. Posting Group");
      // Vendor.VALIDATE(Vendor."Post Code");
       Vendor.VALIDATE(Vendor."No. Series");
       Vendor.VALIDATE(Vendor."Tax Area Code");
       Vendor.VALIDATE(Vendor."Tax Liable");
       Vendor.VALIDATE(Vendor."VAT Bus. Posting Group");
       Vendor.VALIDATE(Vendor."Primary Contact No.");
       Vendor.VALIDATE(Vendor."Responsibility Center");
       Vendor.VALIDATE(Vendor."Location Code");
       Vendor.VALIDATE(Vendor."Lead Time Calculation");
       Vendor.VALIDATE(Vendor."Reverse Auction Participant");
       Vendor.VALIDATE(Vendor."Base Calendar Code");
       Vendor.VALIDATE(Vendor."T.I.N. No.");
       Vendor.VALIDATE(Vendor."Party's L.S.T. No.");
       Vendor.VALIDATE(Vendor."Party's  C.S.T. No.");
       Vendor.VALIDATE(Vendor."P.A.N No.");
       Vendor.VALIDATE(Vendor."E.C.C No.");
       Vendor.VALIDATE(Vendor."State ID No.");
      // Vendor.VALIDATE(Vendor.State);
       Vendor.VALIDATE(Vendor."Excise Bus. Posting Group");
       Vendor.VALIDATE(Vendor."Excise Registration No.");
      // Vendor.VALIDATE(Vendor.SSI);
       Vendor.VALIDATE(Vendor."SSI Validity Date");
       Vendor.VALIDATE(Vendor.Structure);
       Vendor.VALIDATE(Vendor."Vendor Type");
       Vendor.VALIDATE(Vendor."VAT Business Posting Group");
       Vendor.VALIDATE(Vendor.Subcontractor);
       Vendor.VALIDATE(Vendor."Vendor Location");
       Vendor.VALIDATE(Vendor."Commissioner's Permission No.");
       Vendor.MODIFY(TRUE);
       UNTIL Vendor.NEXT=0;
       END;
         */

        /*
       //Item validate
       IF Item.FINDFIRST THEN BEGIN
        FIleName:='item';
        REPEAT
        RecordNo:=Item."No.";
        Window.UPDATE();
        Item.VALIDATE(Item."No.");
        Item.VALIDATE(Item.Class);
       Item.VALIDATE(Item."Base Unit of Measure");
        Item.VALIDATE(Item."Price Unit Conversion");
        Item.VALIDATE(Item."Inventory Posting Group");
        Item.VALIDATE(Item."Shelf No.");
        Item.VALIDATE(Item."Item Disc. Group");
        Item.VALIDATE(Item."Allow Invoice Disc.");
        Item.VALIDATE(Item."Statistics Group");
        Item.VALIDATE(Item."Commission Group");
        Item.VALIDATE(Item."Price/Profit Calculation");
        Item.VALIDATE(Item."Costing Method");
        Item.VALIDATE(Item."Vendor No.");
        Item.VALIDATE(Item."Vendor Item No.");
        Item.VALIDATE(Item."Lead Time Calculation");
        Item.VALIDATE(Item."Reorder Point");
        Item.VALIDATE(Item."Maximum Inventory");
        Item.VALIDATE(Item."Reorder Quantity");
        Item.VALIDATE(Item."Alternative Item No.");
        Item.VALIDATE(Item."Duty Due %");
        Item.VALIDATE(Item."Duty Code");
        Item.VALIDATE(Item."Duty Unit Conversion");
        Item.VALIDATE(Item."Country Purchased Code");
        Item.VALIDATE(Item.Blocked);
        Item.VALIDATE(Item."Gen. Prod. Posting Group");
        Item.VALIDATE(Item."No. Series");
        Item.VALIDATE(Item."Tax Group Code");
        Item.VALIDATE(Item."VAT Prod. Posting Group");
        Item.VALIDATE(Item."Global Dimension 1 Code");
        Item.VALIDATE(Item."Global Dimension 2 Code");
        Item.VALIDATE(Item."Low-Level Code");
        Item.VALIDATE(Item."Lot Size");
        Item.VALIDATE(Item."Serial Nos.");
        Item.VALIDATE(Item."Last Unit Cost Calc. Date");
        Item.VALIDATE(Item."Inventory Value Zero");
        Item.VALIDATE(Item."Discrete Order Quantity");
        Item.VALIDATE(Item."Minimum Order Quantity");
        Item.VALIDATE(Item."Maximum Order Quantity");
        Item.VALIDATE(Item."Safety Stock Quantity");
        Item.VALIDATE(Item."Order Multiple");
        Item.VALIDATE(Item."Safety Lead Time");
        Item.VALIDATE(Item."Flushing Method");
        Item.VALIDATE(Item."Replenishment System");
        Item.VALIDATE(Item."Rounding Precision");
       Item.VALIDATE(Item."Sales Unit of Measure");
       Item.VALIDATE(Item."Purch. Unit of Measure");
        Item.VALIDATE(Item."Reorder Cycle");
        Item.VALIDATE(Item."Reordering Policy");
        Item.VALIDATE(Item."Include Inventory");
        Item.VALIDATE(Item."Manufacturing Policy");
        Item.VALIDATE(Item."Manufacturer Code");
        Item.VALIDATE(Item."Item Category Code");
        Item.VALIDATE(Item."Product Group Code");
        Item.VALIDATE(Item."Service Item Group");
        Item.VALIDATE(Item."Item Tracking Code");
        Item.VALIDATE(Item."Lot Nos.");
        Item.VALIDATE(Item."Expiration Calculation");
        Item.VALIDATE(Item."Special Equipment Code");
       // Item.VALIDATE(Item."Excise Prod. Posting Group");
       // Item.VALIDATE(Item."Excise Accounting Type");
        Item.VALIDATE(Item."Assessable Value");
        Item.VALIDATE(Item."Import Duty Group");
        Item.VALIDATE(Item."Declared Goods");
        Item.VALIDATE(Item."Capital Item");
        Item.VALIDATE(Item."VAT Product Posting Group");
        Item.VALIDATE(Item.Subcontracting);
        Item.VALIDATE(Item."Sub. Comp. Location");
        Item.VALIDATE(Item."Routing No.");
        Item.VALIDATE(Item."Production BOM No.");
        Item.VALIDATE(Item."Order Tracking Policy");
        Item.VALIDATE(Item."Item Sub Group Code");
        Item.VALIDATE(Item."Item Sub Sub Group Code");
        Item.MODIFY(TRUE);
        UNTIL Item.NEXT=0;
        END;
         *///Uday
           /*
         //Resource Group Validate
         IF ResourceGroup.FINDFIRST THEN BEGIN
          FIleName:='Resource Group';
          REPEAT
          RecordNo:=ResourceGroup."No.";
          Window.UPDATE();
          ResourceGroup.VALIDATE(ResourceGroup."No.");
          ResourceGroup.VALIDATE(ResourceGroup."Global Dimension 1 Code");
          ResourceGroup.VALIDATE(ResourceGroup."Global Dimension 2 Code");
          ResourceGroup.MODIFY(TRUE);
          UNTIL ResourceGroup.NEXT=0;
          END;
         //ELSE
         //  ERROR('Cannot Proceed without Resource Groups');

         //Resource Validate
         IF Resource.FINDFIRST THEN BEGIN
          FIleName:='Resource';
          REPEAT
          RecordNo:=Resource."No.";
          Window.UPDATE();
          Resource.VALIDATE(Resource."No.");
          Resource.VALIDATE(Resource.Type);
          Resource.VALIDATE(Resource."Resource Group No.");
          Resource.VALIDATE(Resource."Global Dimension 1 Code");
          Resource.VALIDATE(Resource."Global Dimension 2 Code");
          Resource.VALIDATE(Resource."Base Unit of Measure");
          Resource.VALIDATE(Resource."Vendor No.");
          Resource.VALIDATE(Resource.Blocked);
          Resource.VALIDATE(Resource."Gen. Prod. Posting Group");
          Resource.VALIDATE(Resource."No. Series");
          Resource.VALIDATE(Resource."Tax Group Code");
          Resource.VALIDATE(Resource."VAT Prod. Posting Group");
          Resource.VALIDATE(Resource."Country Code");
          Resource.VALIDATE(Resource."Service Zone Filter");
           Resource.MODIFY(TRUE);
          UNTIL Resource.NEXT=0;
          END;

         //ResourceUnitofMeasure validate
         IF ResourceUnitofMeasure.FINDFIRST THEN BEGIN
          FIleName:='Resource UOM';
          REPEAT
          RecordNo:=ResourceUnitofMeasure."Resource No.";
          Window.UPDATE();
          ResourceUnitofMeasure.VALIDATE(ResourceUnitofMeasure."Resource No.");
          ResourceUnitofMeasure.VALIDATE(ResourceUnitofMeasure.Code);
          ResourceUnitofMeasure.VALIDATE(ResourceUnitofMeasure."Qty. per Unit of Measure");
          ResourceUnitofMeasure.VALIDATE(ResourceUnitofMeasure."Related to Base Unit of Meas.");
          ResourceUnitofMeasure.MODIFY(TRUE);
          UNTIL ResourceUnitofMeasure.NEXT=0;
          END;
          */
           /*
           //ItemUnitofMeasure validate
           IF ItemUnitofMeasure.FINDFIRST THEN BEGIN
            FIleName:='Item UOM';
            REPEAT
            RecordNo:=ItemUnitofMeasure."Item No.";
            Window.UPDATE();
            ItemUnitofMeasure.VALIDATE(ItemUnitofMeasure."Item No.");
            ItemUnitofMeasure.VALIDATE(ItemUnitofMeasure.Code);
            ItemUnitofMeasure.VALIDATE(ItemUnitofMeasure."Qty. per Unit of Measure");
            ItemUnitofMeasure.MODIFY(TRUE);
            UNTIL ItemUnitofMeasure.NEXT=0;
            END;
            */
           /*
          //BankAccount validate
          IF BankAccount.FINDFIRST THEN BEGIN
           FIleName:='Bank';
           REPEAT
           RecordNo:=BankAccount."No.";
           Window.UPDATE();
           BankAccount.VALIDATE(BankAccount."No.");
           BankAccount.VALIDATE(BankAccount.Contact);
           BankAccount.VALIDATE(BankAccount."Bank Account No.");
           BankAccount.VALIDATE(BankAccount."Global Dimension 1 Code");
           BankAccount.VALIDATE(BankAccount."Global Dimension 2 Code");
           BankAccount.VALIDATE(BankAccount."Min. Balance");
           BankAccount.VALIDATE(BankAccount."Bank Acc. Posting Group");
           BankAccount.VALIDATE(BankAccount."Currency Code");
           BankAccount.VALIDATE(BankAccount."Language Code");
           BankAccount.VALIDATE(BankAccount."Country Code");
           BankAccount.VALIDATE(BankAccount.Blocked);
           BankAccount.VALIDATE(BankAccount."Last Check No.");
           BankAccount.VALIDATE(BankAccount."Bank Branch No.");
           BankAccount.VALIDATE(BankAccount."No. Series");
           BankAccount.MODIFY(TRUE);
           UNTIL BankAccount.NEXT=0;
           END;
          */
           /*
           //Dimension validate
           IF Dimension.FINDFIRST THEN BEGIN
            FIleName:='Dimension';
            REPEAT
            RecordNo:=Dimension.Code;
            Window.UPDATE();
            Dimension.VALIDATE(Dimension."Code Caption");
            Dimension.VALIDATE(Dimension."Filter Caption");
            Dimension.VALIDATE(Dimension.Blocked);
            Dimension.VALIDATE(Dimension."Consolidation Code");
            Dimension.MODIFY(TRUE);
            UNTIL Dimension.NEXT=0;
            END;

           //DimensionValue Validate
           IF DimensionValue.FINDFIRST THEN BEGIN
            FIleName:='Dimension Value';
            REPEAT
            RecordNo:=DimensionValue.Code;
            Window.UPDATE();
            DimensionValue.VALIDATE(DimensionValue."Dimension Code");
            DimensionValue.VALIDATE(DimensionValue.Code);
            DimensionValue.VALIDATE(DimensionValue."Dimension Value Type");
            DimensionValue.VALIDATE(DimensionValue.Totaling);
            DimensionValue.VALIDATE(DimensionValue.Blocked);
            DimensionValue.VALIDATE(DimensionValue."Consolidation Code");
            DimensionValue.VALIDATE(DimensionValue.Indentation);
            DimensionValue.VALIDATE(DimensionValue."Global Dimension No.");
            DimensionValue.MODIFY(TRUE);
            UNTIL DimensionValue.NEXT=0;
            END;

           //DimensionCombination validate
           IF DimensionCombination.FINDFIRST THEN  BEGIN
            FIleName:='Dimension Combination';
            REPEAT
            RecordNo:=DimensionCombination."Dimension 1 Code";
            Window.UPDATE();
            DimensionCombination.VALIDATE(DimensionCombination."Dimension 1 Code");
            DimensionCombination.VALIDATE(DimensionCombination."Dimension 2 Code");
            DimensionCombination.VALIDATE(DimensionCombination."Combination Restriction");
            DimensionCombination.MODIFY(TRUE);
            UNTIL DimensionCombination.NEXT=0;
            END;

           //DimensionValueCombination validate

           IF DimensionValueCombination.FINDFIRST THEN BEGIN
            FIleName:='Dimension Value Comb';
            REPEAT
            RecordNo:=DimensionValueCombination."Dimension 1 Code";
            Window.UPDATE();
            DimensionValueCombination.VALIDATE(DimensionValueCombination."Dimension 1 Code");
            DimensionValueCombination.VALIDATE(DimensionValueCombination."Dimension 1 Value Code");
            DimensionValueCombination.VALIDATE(DimensionValueCombination."Dimension 2 Code");
            DimensionValueCombination.VALIDATE(DimensionValueCombination."Dimension 2 Value Code");
            DimensionValueCombination.MODIFY(TRUE);
            UNTIL DimensionValueCombination.NEXT=0;
            END;



           //DefaultDimension validate
           IF DefaultDimension.FINDFIRST THEN BEGIN
            FIleName:='Default Dimension';
            REPEAT
            RecordNo:=DefaultDimension."No.";
            Window.UPDATE();
            DefaultDimension.VALIDATE(DefaultDimension."Table ID");
            DefaultDimension.VALIDATE(DefaultDimension."No.");
            DefaultDimension.VALIDATE(DefaultDimension."Dimension Code");
            DefaultDimension.VALIDATE(DefaultDimension."Dimension Value Code");
            DefaultDimension.VALIDATE(DefaultDimension."Value Posting");
            DefaultDimension.VALIDATE(DefaultDimension."Multi Selection Action");
            DefaultDimension.MODIFY(TRUE);
            UNTIL DefaultDimension.NEXT=0;
            END;
            */
           /*
           //Employee validate
           IF Employee.FINDFIRST THEN BEGIN
            FIleName:='Employee';
            REPEAT
            RecordNo:=Employee."No.";
            Window.UPDATE();
            Employee.VALIDATE(Employee."No.");
            Employee.VALIDATE(Employee.Initials);
            Employee.VALIDATE(Employee."Job Title");
            Employee.VALIDATE(Employee.City);
            Employee.VALIDATE(Employee."Post Code");
            Employee.VALIDATE(Employee.County);
            Employee.VALIDATE(Employee."Alt. Address Code");
            Employee.VALIDATE(Employee."Alt. Address Start Date");
            Employee.VALIDATE(Employee."Alt. Address End Date");
            Employee.VALIDATE(Employee."Country Code");
            Employee.VALIDATE(Employee."Manager No.");
            Employee.VALIDATE(Employee."Emplymt. Contract Code");
            Employee.VALIDATE(Employee."Statistics Group Code");
            Employee.VALIDATE(Employee."Employment Date");
            Employee.VALIDATE(Employee.Status);
            Employee.VALIDATE(Employee."Cause of Inactivity Code");
            Employee.VALIDATE(Employee."Termination Date");
            Employee.VALIDATE(Employee."Grounds for Term. Code");
            Employee.VALIDATE(Employee."Global Dimension 1 Code");
            Employee.VALIDATE(Employee."Global Dimension 2 Code");
            Employee.VALIDATE(Employee."Resource No.");
            Employee.VALIDATE(Employee."No. Series");
            Employee.VALIDATE(Employee."Job Title/Grade");
            Employee.VALIDATE(Employee."Department Code");
            Employee.VALIDATE(Employee."Project Code");
            Employee.VALIDATE(Employee."Location Code");
            Employee.VALIDATE(Employee."Qualification Code");
            Employee.VALIDATE(Employee."Sanctioning Incharge");
            Employee.VALIDATE(Employee."Skill Code");
            Employee.VALIDATE(Employee."Branch Code");
            Employee.VALIDATE(Employee."No of Children");
            Employee.VALIDATE(Employee."Entitiled To Overtime");
            Employee.VALIDATE(Employee."Entitlement to ESI");
            Employee.VALIDATE(Employee."Entitlement to PF");
            Employee.VALIDATE(Employee."PAN No");
            Employee.VALIDATE(Employee."ESI No");
            Employee.VALIDATE(Employee."PF No");
            Employee.VALIDATE(Employee."ESI Dispensary");
            Employee.VALIDATE(Employee."Father/Husband");
            Employee.VALIDATE(Employee."Salary Stopped");
            Employee.VALIDATE(Employee."Payment Method");
            Employee.VALIDATE(Employee."Bank Code");
            Employee.VALIDATE(Employee."Bank Name");
            Employee.VALIDATE(Employee."Bank Branch");
            Employee.VALIDATE(Employee."Account Type");
            Employee.VALIDATE(Employee."Account No");
            Employee.MODIFY(TRUE);
            UNTIL Employee.NEXT=0;
            END;
            */
           /*
           //Fixed Asset validate
           IF FixedAsset.FINDFIRST THEN BEGIN
            FIleName:='Fixed Asset';
            REPEAT
            RecordNo:=FixedAsset."No.";
            Window.UPDATE();
            FixedAsset.VALIDATE(FixedAsset."No.");
            FixedAsset.VALIDATE(FixedAsset."FA Class Code");
            FixedAsset.VALIDATE(FixedAsset."FA Subclass Code");
            FixedAsset.VALIDATE(FixedAsset."Global Dimension 1 Code");
            FixedAsset.VALIDATE(FixedAsset."Global Dimension 2 Code");
            FixedAsset.VALIDATE(FixedAsset."Location Code");
            FixedAsset.VALIDATE(FixedAsset."FA Location Code");
            FixedAsset.VALIDATE(FixedAsset."Vendor No.");
            FixedAsset.VALIDATE(FixedAsset."Main Asset/Component");
            FixedAsset.VALIDATE(FixedAsset."Component of Main Asset");
            FixedAsset.VALIDATE(FixedAsset."Budgeted Asset");
            FixedAsset.VALIDATE(FixedAsset."Responsible Employee");
            FixedAsset.VALIDATE(FixedAsset."Serial No.");
            FixedAsset.VALIDATE(FixedAsset.Blocked);
            FixedAsset.VALIDATE(FixedAsset."Maintenance Vendor No.");
            FixedAsset.VALIDATE(FixedAsset."Under Maintenance");
            FixedAsset.VALIDATE(FixedAsset."Next Service Date");
            FixedAsset.VALIDATE(FixedAsset.Inactive);
            FixedAsset.VALIDATE(FixedAsset."No. Series");
            FixedAsset.VALIDATE(FixedAsset."FA Posting Group");
            FixedAsset.VALIDATE(FixedAsset."Excise Prod. Posting Group");
            FixedAsset.VALIDATE(FixedAsset."Excise Accounting Type");
            FixedAsset.VALIDATE(FixedAsset."Gen. Prod. Posting Group");
            FixedAsset.VALIDATE(FixedAsset."Tax Group Code");
            FixedAsset.VALIDATE(FixedAsset."Import Duty Group");
            FixedAsset.VALIDATE(FixedAsset."VAT Product Posting Group");
            FixedAsset.VALIDATE(FixedAsset."FA Posting Date Filter");
           // FixedAsset.VALIDATE(FixedAsset.Insured);
            FixedAsset.MODIFY(TRUE);
            UNTIL FixedAsset.NEXT=0;
            END;
           */
           /*
           //DepreciationBook validate
           IF DepreciationBook.FINDFIRST THEN BEGIN
            FIleName:='Derpeciation Book';
            REPEAT
            RecordNo:=DepreciationBook.Code;
            Window.UPDATE();
            DepreciationBook.VALIDATE(DepreciationBook.Code);
            DepreciationBook.VALIDATE(DepreciationBook."G/L Integration - Acq. Cost");
            DepreciationBook.VALIDATE(DepreciationBook."G/L Integration - Depreciation");
            DepreciationBook.VALIDATE(DepreciationBook."G/L Integration - Write-Down");
            DepreciationBook.VALIDATE(DepreciationBook."G/L Integration - Appreciation");
            DepreciationBook.VALIDATE(DepreciationBook."G/L Integration - Custom 1");
            DepreciationBook.VALIDATE(DepreciationBook."G/L Integration - Custom 2");
            DepreciationBook.VALIDATE(DepreciationBook."G/L Integration - Disposal");
            DepreciationBook.VALIDATE(DepreciationBook."G/L Integration - Maintenance");
            DepreciationBook.VALIDATE(DepreciationBook."Disposal Calculation Method");
            DepreciationBook.VALIDATE(DepreciationBook."Use Custom 1 Depreciation");
            DepreciationBook.VALIDATE(DepreciationBook."Allow Depr. below Zero");
            DepreciationBook.VALIDATE(DepreciationBook."Use FA Exch. Rate in Duplic.");
            DepreciationBook.VALIDATE(DepreciationBook."Part of Duplication List");
            DepreciationBook.VALIDATE(DepreciationBook."Last Date Modified");
            DepreciationBook.VALIDATE(DepreciationBook."Allow Indexation");
            DepreciationBook.VALIDATE(DepreciationBook."Use Same FA+G/L Posting Dates");
            DepreciationBook.VALIDATE(DepreciationBook."Default Exchange Rate");
            DepreciationBook.VALIDATE(DepreciationBook."Use FA Ledger Check");
            DepreciationBook.VALIDATE(DepreciationBook."Use Rounding in Periodic Depr.");
            DepreciationBook.VALIDATE(DepreciationBook."New Fiscal Year Starting Date");
            DepreciationBook.VALIDATE(DepreciationBook."No. of Days in Fiscal Year");
            DepreciationBook.VALIDATE(DepreciationBook."Allow Changes in Depr. Fields");
            DepreciationBook.VALIDATE(DepreciationBook."Default Final Rounding Amount");
            DepreciationBook.VALIDATE(DepreciationBook."Default Ending Book Value");
            DepreciationBook.VALIDATE(DepreciationBook."Periodic Depr. Date Calc.");
            DepreciationBook.VALIDATE(DepreciationBook."Mark Errors as Corrections");
            DepreciationBook.VALIDATE(DepreciationBook."Add-Curr Exch Rate - Acq. Cost");
            DepreciationBook.VALIDATE(DepreciationBook."Add.-Curr. Exch. Rate - Depr.");
            DepreciationBook.VALIDATE(DepreciationBook."Add-Curr Exch Rate -Write-Down");
            DepreciationBook.VALIDATE(DepreciationBook."Add-Curr. Exch. Rate - Apprec.");
            DepreciationBook.VALIDATE(DepreciationBook."Add-Curr. Exch Rate - Custom 1");
            DepreciationBook.VALIDATE(DepreciationBook."Add.-Curr. Exch. Rate - Maint.");
            DepreciationBook.VALIDATE(DepreciationBook."Add-Curr. Exch Rate - Custom 2");
            DepreciationBook.VALIDATE(DepreciationBook."Add.-Curr. Exch. Rate - Disp.");
            DepreciationBook.VALIDATE(DepreciationBook."Use Default Dimension");
            DepreciationBook.VALIDATE(DepreciationBook."Subtract Disc. in Purch. Inv.");
            DepreciationBook.MODIFY(TRUE);
            UNTIL DepreciationBook.NEXT=0;
            END;

           //FA Depreciation Book validate
           IF FADepreciationBook.FINDFIRST THEN  BEGIN
            FIleName:='FA Dep. Book';
            REPEAT
            RecordNo:=FADepreciationBook."FA No.";
            Window.UPDATE();
            FADepreciationBook.VALIDATE(FADepreciationBook."FA No.");
            FADepreciationBook.VALIDATE(FADepreciationBook."Depreciation Book Code");
            FADepreciationBook.VALIDATE(FADepreciationBook."Depreciation Method");
            FADepreciationBook.VALIDATE(FADepreciationBook."Depreciation Starting Date");
            FADepreciationBook.VALIDATE(FADepreciationBook."Straight-Line %");
            FADepreciationBook.VALIDATE(FADepreciationBook."No. of Depreciation Years");
            FADepreciationBook.VALIDATE(FADepreciationBook."No. of Depreciation Months");
            FADepreciationBook.VALIDATE(FADepreciationBook."Fixed Depr. Amount");
            FADepreciationBook.VALIDATE(FADepreciationBook."Declining-Balance %");
            FADepreciationBook.VALIDATE(FADepreciationBook."Depreciation Table Code");
            FADepreciationBook.VALIDATE(FADepreciationBook."Final Rounding Amount");
            FADepreciationBook.VALIDATE(FADepreciationBook."Ending Book Value");
            FADepreciationBook.VALIDATE(FADepreciationBook."FA Posting Group");
            FADepreciationBook.VALIDATE(FADepreciationBook."Depreciation Ending Date");
            FADepreciationBook.VALIDATE(FADepreciationBook."Acquisition Date");
            FADepreciationBook.VALIDATE(FADepreciationBook."G/L Acquisition Date");
            FADepreciationBook.VALIDATE(FADepreciationBook."Disposal Date");
            FADepreciationBook.VALIDATE(FADepreciationBook."Last Acquisition Cost Date");
            FADepreciationBook.VALIDATE(FADepreciationBook."Last Depreciation Date");
            FADepreciationBook.VALIDATE(FADepreciationBook."Last Write-Down Date");
            FADepreciationBook.VALIDATE(FADepreciationBook."Last Appreciation Date");
            FADepreciationBook.VALIDATE(FADepreciationBook."Last Custom 1 Date");
            FADepreciationBook.VALIDATE(FADepreciationBook."Last Custom 2 Date");
            FADepreciationBook.VALIDATE(FADepreciationBook."Last Salvage Value Date");
            FADepreciationBook.VALIDATE(FADepreciationBook."FA Exchange Rate");
            FADepreciationBook.VALIDATE(FADepreciationBook."Fixed Depr. Amount below Zero");
            FADepreciationBook.VALIDATE(FADepreciationBook."Last Date Modified");
            FADepreciationBook.VALIDATE(FADepreciationBook."First User-Defined Depr. Date");
            FADepreciationBook.VALIDATE(FADepreciationBook."Use FA Ledger Check");
            FADepreciationBook.VALIDATE(FADepreciationBook."Last Maintenance Date");
            FADepreciationBook.VALIDATE(FADepreciationBook."Depr. below Zero %");
            FADepreciationBook.VALIDATE(FADepreciationBook."Projected Disposal Date");
            FADepreciationBook.VALIDATE(FADepreciationBook."Projected Proceeds on Disposal");
            FADepreciationBook.VALIDATE(FADepreciationBook."Depr. Starting Date (Custom 1)");
            FADepreciationBook.VALIDATE(FADepreciationBook."Depr. Ending Date (Custom 1)");
            FADepreciationBook.VALIDATE(FADepreciationBook."Accum. Depr. % (Custom 1)");
            FADepreciationBook.VALIDATE(FADepreciationBook."Depr. This Year % (Custom 1)");
            FADepreciationBook.VALIDATE(FADepreciationBook."Property Class (Custom 1)");
            FADepreciationBook.VALIDATE(FADepreciationBook.Description);
            FADepreciationBook.VALIDATE(FADepreciationBook."Main Asset/Component");
            FADepreciationBook.VALIDATE(FADepreciationBook."Component of Main Asset");
            FADepreciationBook.VALIDATE(FADepreciationBook."FA Add.-Currency Factor");
            FADepreciationBook.VALIDATE(FADepreciationBook."Use Half-Year Convention");
            FADepreciationBook.VALIDATE(FADepreciationBook."Use DB% First Fiscal Year");
            FADepreciationBook.MODIFY(TRUE);
            UNTIL FADepreciationBook.NEXT=0;
            END;
            */


        /*
       //Service Item validate
       IF ServiceItem.FINDFIRST THEN BEGIN
        FIleName:='Service Item';
        REPEAT
        RecordNo:=ServiceItem."No.";
        Window.UPDATE();
        ServiceItem.VALIDATE(ServiceItem."No.");
        ServiceItem.VALIDATE(ServiceItem."Serial No.");
        ServiceItem.VALIDATE(ServiceItem."Service Item Group Code");
        ServiceItem.VALIDATE(ServiceItem.Status);
        ServiceItem.VALIDATE(ServiceItem.Priority);
        ServiceItem.VALIDATE(ServiceItem."Customer No.");
        ServiceItem.VALIDATE(ServiceItem."Ship-to Code");
        ServiceItem.VALIDATE(ServiceItem."Item No.");
        ServiceItem.VALIDATE(ServiceItem."Unit of Measure Code");
        ServiceItem.VALIDATE(ServiceItem."Location of Service Item");
        ServiceItem.VALIDATE(ServiceItem."Sales Unit Price");
        ServiceItem.VALIDATE(ServiceItem."Sales Unit Cost");
        ServiceItem.VALIDATE(ServiceItem."Warranty Starting Date (Labor)");
        ServiceItem.VALIDATE(ServiceItem."Warranty Ending Date (Labor)");
        ServiceItem.VALIDATE(ServiceItem."Warranty Starting Date (Parts)");
        ServiceItem.VALIDATE(ServiceItem."Warranty Ending Date (Parts)");
        ServiceItem.VALIDATE(ServiceItem."Warranty % (Parts)");
        ServiceItem.VALIDATE(ServiceItem."Warranty % (Labor)");
        ServiceItem.VALIDATE(ServiceItem."Response Time (Hours)");
        ServiceItem.VALIDATE(ServiceItem."Installation Date");
        ServiceItem.VALIDATE(ServiceItem."Sales Date");
        ServiceItem.VALIDATE(ServiceItem."Last Service Date");
        ServiceItem.VALIDATE(ServiceItem."Vendor No.");
        ServiceItem.VALIDATE(ServiceItem."Vendor Item No.");
        ServiceItem.VALIDATE(ServiceItem."No. Series");
        ServiceItem.VALIDATE(ServiceItem."Preferred Resource");
        ServiceItem.VALIDATE(ServiceItem."Variant Code");
        ServiceItem.VALIDATE(ServiceItem."Service Price Group Code");
        ServiceItem.VALIDATE(ServiceItem."Sales Shipment Document No.");
        ServiceItem.VALIDATE(ServiceItem."Sales Shipment Line No.");
        ServiceItem.MODIFY(TRUE);
        UNTIL ServiceItem.NEXT=0;
        END;
         */
        /*
       //Work Center validate
       IF WorkCenter.FINDFIRST THEN BEGIN
        FIleName:='Work Centre';
        REPEAT
        RecordNo:=WorkCenter."No.";
        Window.UPDATE();
        WorkCenter.VALIDATE(WorkCenter."Post Code");
        WorkCenter.VALIDATE(WorkCenter."Alternate Work Center");
        WorkCenter.VALIDATE(WorkCenter."Work Center Group Code");
        WorkCenter.VALIDATE(WorkCenter."Global Dimension 1 Code");
        WorkCenter.VALIDATE(WorkCenter."Global Dimension 2 Code");
        WorkCenter.VALIDATE(WorkCenter."Subcontractor No.");
        WorkCenter.VALIDATE(WorkCenter."Queue Time");
        WorkCenter.VALIDATE(WorkCenter."Queue Time Unit of Meas. Code");
        WorkCenter.VALIDATE(WorkCenter."Unit of Measure Code");
        WorkCenter.VALIDATE(WorkCenter.Capacity);
        WorkCenter.VALIDATE(WorkCenter.Efficiency);
        WorkCenter.VALIDATE(WorkCenter."Maximum Efficiency");
        WorkCenter.VALIDATE(WorkCenter."Minimum Efficiency");
        WorkCenter.VALIDATE(WorkCenter."Calendar Rounding Precision");
        WorkCenter.VALIDATE(WorkCenter."Simulation Type");
        WorkCenter.VALIDATE(WorkCenter."Shop Calendar Code");
        WorkCenter.VALIDATE(WorkCenter.Blocked);
        WorkCenter.VALIDATE(WorkCenter."Unit Cost Calculation");
        WorkCenter.VALIDATE(WorkCenter."Consolidated Calendar");
        WorkCenter.VALIDATE(WorkCenter."Flushing Method");
        WorkCenter.VALIDATE(WorkCenter."No. Series");
        WorkCenter.VALIDATE(WorkCenter."Gen. Prod. Posting Group");
        WorkCenter.MODIFY(TRUE);
        UNTIL WorkCenter.NEXT=0;
        END;
        */

        /*
        //ProductionBOMHeader validate
        IF ProductionBOMHeader.FINDFIRST THEN BEGIN
         FIleName:='Production BOM Header';
         REPEAT
         RecordNo:=ProductionBOMHeader."No.";
         Window.UPDATE();
         ProductionBOMHeader.VALIDATE(ProductionBOMHeader.Status,ProductionBOMHeader.Status::New);
         ProductionBOMHeader.VALIDATE(ProductionBOMHeader."Low-Level Code");
         ProductionBOMHeader.VALIDATE(ProductionBOMHeader."Version Nos.");
         ProductionBOMHeader.VALIDATE(ProductionBOMHeader."No. Series");
         ProductionBOMHeader.MODIFY(TRUE);
         UNTIL ProductionBOMHeader.NEXT=0;
         END;
         */


        //ProductionBOMLine validate

        IF ProductionBOMLine.FINDFIRST THEN BEGIN
            FIleName := 'Production BOM Line';
            REPEAT
                RecordNo := ProductionBOMLine."Production BOM No.";
                Window.UPDATE();
                ProductionBOMLine.VALIDATE(ProductionBOMLine."Production BOM No.");
                //rasool
                //ProductionBOMLine.VALIDATE(ProductionBOMLine."Version Code");
                ProductionBOMLine.VALIDATE(ProductionBOMLine."No.");
                ProductionBOMLine.VALIDATE(ProductionBOMLine."Line No.");
                ProductionBOMLine.VALIDATE(ProductionBOMLine.Type);
                ProductionBOMLine.VALIDATE(ProductionBOMLine."Unit of Measure Code");
                // ProductionBOMLine.VALIDATE(ProductionBOMLine."Production Lead Time");//B2B
                ProductionBOMLine.VALIDATE(ProductionBOMLine."Routing Link Code");
                ProductionBOMLine.VALIDATE(ProductionBOMLine."Quantity per");
                ProductionBOMLine.MODIFY(TRUE);
            UNTIL ProductionBOMLine.NEXT = 0;
        END;


        IF ProductionBOMLine.FINDFIRST THEN BEGIN
            FIleName := 'Production BOM Line';
            REPEAT
                RecordNo := ProductionBOMLine."Production BOM No.";
                Window.UPDATE();
                ProductionBOMLine.VALIDATE(ProductionBOMLine."Production BOM No.");
                ProductionBOMLine.VALIDATE(ProductionBOMLine."No.");
                ProductionBOMLine.VALIDATE(ProductionBOMLine."Line No.");
                ProductionBOMLine.VALIDATE(ProductionBOMLine.Type);
                ProductionBOMLine.VALIDATE(ProductionBOMLine."No.");
                ProductionBOMLine.VALIDATE(ProductionBOMLine."Unit of Measure Code");
                //   ProductionBOMLine.VALIDATE(ProductionBOMLine."Production Lead Time");//B2b
                ProductionBOMLine.VALIDATE(ProductionBOMLine."Routing Link Code");
                ProductionBOMLine.VALIDATE(ProductionBOMLine."Quantity per");
                ProductionBOMLine.MODIFY(TRUE);
            UNTIL ProductionBOMLine.NEXT = 0;
        END;



        /*

       IF ProductionBOMLine.FINDFIRST THEN
        REPEAT
          ProductionBOMLine.VALIDATE(ProductionBOMLine."Production BOM No.");
          ProductionBOMLine.VALIDATE(ProductionBOMLine."No.");
          ProductionBOMLine.VALIDATE(ProductionBOMLine."Line No.");
       //   ProductionBOMLine.VALIDATE(ProductionBOMLine.Type);
          ProductionBOMLine.VALIDATE(ProductionBOMLine."No.");
          ProductionBOMLine.VALIDATE(ProductionBOMLine."Unit of Measure Code");
          ProductionBOMLine.VALIDATE(ProductionBOMLine."Production Lead Time");
          ProductionBOMLine.VALIDATE(ProductionBOMLine."Routing Link Code");
          ProductionBOMLine.VALIDATE(ProductionBOMLine."Quantity per");
          ProductionBOMLine.MODIFY(TRUE);
        UNTIL ProductionBOMLine.NEXT=0;
       MESSAGE('Done');

        */

        IF ProductionBOMHeader.FINDFIRST THEN
            REPEAT
                ProductionBOMHeader.VALIDATE(ProductionBOMHeader.Status, ProductionBOMHeader.Status::Certified);
                ProductionBOMHeader.MODIFY(TRUE);
            UNTIL ProductionBOMHeader.NEXT = 0;
        /*
        FACOmponents.FINDFIRST;
        REPEAT
        FACOmponents.VALIDATE(FACOmponents."Main Asset No.");
        FACOmponents.VALIDATE(FACOmponents."FA No.");
        FACOmponents.MODIFY;
        UNTIL FACOmponents.NEXT=0;
        
        
        IF currency.FINDFIRST THEN BEGIN
         FIleName:='Currency';
         REPEAT
         RecordNo:=currency.Code;
         Window.UPDATE();
         currency.VALIDATE(currency.Code);
         currency.VALIDATE(currency."Unrealized Gains Acc.");
         currency.VALIDATE(currency."Realized Gains Acc.");
         currency.VALIDATE(currency."Unrealized Losses Acc.");
         currency.VALIDATE(currency."Realized Losses Acc.");
         currency.VALIDATE(currency."Invoice Rounding Precision");
         currency.VALIDATE(currency."Invoice Rounding Type");
         currency.VALIDATE(currency."Amount Rounding Precision");
         currency.VALIDATE(currency."Unit-Amount Rounding Precision");
         currency.VALIDATE(currency."Amount Decimal Places");
         currency.VALIDATE(currency."Unit-Amount Decimal Places");
         currency.VALIDATE(currency."Realized G/L Gains Account");
         currency.VALIDATE(currency."Realized G/L Losses Account");
         currency.VALIDATE(currency."Appln. Rounding Precision");
         currency.VALIDATE(currency."Residual Gains Account");
         currency.VALIDATE(currency."Residual Losses Account");
         currency.MODIFY;
        UNTIL currency.NEXT=0;
        END;
        */
        /*
        IF MachineCentre.FINDFIRST THEN BEGIN
         FIleName:='Machine Centre';
         REPEAT
         RecordNo:=MachineCentre."No.";
         Window.UPDATE();
         MachineCentre.VALIDATE(MachineCentre."No.");
         MachineCentre.VALIDATE(MachineCentre."Work Center No.");
         MachineCentre.VALIDATE(MachineCentre."Gen. Prod. Posting Group");
         MachineCentre.VALIDATE(MachineCentre.Capacity);
         MachineCentre.VALIDATE(MachineCentre.Efficiency);
         MachineCentre.VALIDATE(MachineCentre."Flushing Method");
        UNTIL MachineCentre.NEXT=0;
        END;
         */
        /*
        IF ipg.FINDFIRST THEN BEGIN
         FIleName:='ipg';
         REPEAT
         RecordNo:=ipg."Location Code";
         Window.UPDATE();
          ipg.VALIDATE(ipg."Location Code");
          ipg.VALIDATE(ipg."Invt. Posting Group Code");
          ipg.VALIDATE(ipg."Inventory Account");
          ipg.VALIDATE(ipg."Unrealized Profit Account");
          ipg.VALIDATE(ipg."WIP Account");
        UNTIL ipg.NEXT=0;
        END;
        
        */

        Window.CLOSE();

        MESSAGE('Done');

    end;

    var
        Location: Record Location;
        COA: Record "G/L Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        Item: Record Item;
        ResourceGroup: Record "Resource Group";
        Resource: Record Resource;
        UnitofMeasure: Record "Unit of Measure";
        ResourceUnitofMeasure: Record "Resource Unit of Measure";
        ItemUnitofMeasure: Record "Item Unit of Measure";
        BankAccount: Record "Bank Account";
        Dimension: Record Dimension;
        DimensionValue: Record "Dimension Value";
        DimensionCombination: Record "Dimension Combination";
        DimensionValueCombination: Record "Dimension Value Combination";
        DefaultDimension: Record "Default Dimension";
        Employee: Record Employee;
        FixedAsset: Record "Fixed Asset";
        DepreciationBook: Record "Depreciation Book";
        FADepreciationBook: Record "FA Depreciation Book";
        ServiceItem: Record "Service Item";
        WorkCenter: Record "Work Center";
        RoutingHeader: Record "Routing Header";
        RoutingLine: Record "Routing Line";
        ProductionBOMHeader: Record "Production BOM Header";
        ProductionBOMLine: Record "Production BOM Line";
        Window: Dialog;
        FIleName: Text[30];
        RecordNo: Code[30];
        FACOmponents: Record "Main Asset Component";
        currency: Record Currency;
        MachineCentre: Record "Machine Center";
        ipg: Record "Inventory Posting Setup";
}

