pageextension 70081 ItemListExt extends 31
{
    layout
    {
        modify("No.")
        {
            StyleExpr = "No.Format";
            Editable = false;
        }
        modify(Description)
        {
            Style = Ambiguous;
            StyleExpr = DescriptionEmphasize;
            Editable = false;
        }
        modify("Created From Nonstock Item")
        {
            Visible = false;
        }
        modify("Substitutes Exist")
        {
            Visible = false;
        }
        modify("Stockkeeping Unit Exists")
        {
            Visible = false;
        }
        modify("Assembly BOM")
        {
            Visible = false;
        }
        modify("Production BOM No.")
        {
            Visible = false;
        }
        modify("Routing No.")
        {
            Visible = false;
        }
        modify("Costing Method")
        {
            Visible = false;
        }
        modify("Cost is Adjusted")
        {
            Visible = false;
        }
        addafter(Description)
        {
            field("Description 2"; Rec."Description 2")
            {
                ApplicationArea = All;
            }
            field("No of Panels"; Rec."No of Panels")
            {
                ApplicationArea = All;
            }
            field(SMD_But_mchine_cant_do; Rec.SMD_But_mchine_cant_do)
            {
                ApplicationArea = All;
            }
            /* field("GST Group Code"; "GST Group Code")
            {
            }
            field("HSN/SAC Code"; "HSN/SAC Code")
            {
            } */                                        //Removed In BC
            field(Package; Rec.Package)
            {
                ApplicationArea = All;
            }
            field(EFF_MOQ; Rec.EFF_MOQ)
            {
                ApplicationArea = All;
            }
            field("Stock at Stores"; Rec."Stock at Stores")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Stock At MCH Location"; Rec."Stock At MCH Location")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Part Number"; Rec."Part Number")
            {
                ApplicationArea = All;
            }
            field(Make; Rec.Make)
            {
                ApplicationArea = All;
            }
            field("Minimum Order Quantity"; Rec."Minimum Order Quantity")
            {
                Editable = true;
                ApplicationArea = All;
            }
            field("Order Multiple"; Rec."Order Multiple")
            {
                ApplicationArea = All;
            }
            field("Safety Stock Quantity"; Rec."Safety Stock Quantity")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Safety Lead Time"; Rec."Safety Lead Time")
            {
                Editable = true;
                ApplicationArea = All;
            }
        }
        addafter("Last Direct Cost")
        {
            field("Avg Unit Cost"; Rec."Avg Unit Cost")
            {
                ApplicationArea = All;
            }
        }
        addafter("Item Disc. Group")
        {

            field("Item Sub Group Code"; Rec."Item Sub Group Code")
            {
                ApplicationArea = All;
            }
            field("Item Sub Sub Group Code"; Rec."Item Sub Sub Group Code")
            {
                ApplicationArea = All;
            }
            field("Qty. on Purch. Order"; Rec."Qty. on Purch. Order")
            {
                ApplicationArea = All;
            }
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = All;
            }
            field("<Search Description 2>"; Rec."Search Description")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Rounding Precision"; Rec."Rounding Precision")
            {
                ApplicationArea = All;
            }
            field("QC Enabled"; Rec."QC Enabled")
            {
                ApplicationArea = All;
            }
            field(Qc_Item; Rec.Qc_Item)
            {
                ApplicationArea = All;
            }
            field("BIN Address"; Rec."BIN Address")
            {
                ApplicationArea = All;
            }
            field("Stock Address"; Rec."Stock Address")
            {
                ApplicationArea = All;
            }
            field("Product Group Code Cust";Rec."Product Group Code Cust")
            {
                ApplicationArea = All;
            }

        }
        addafter(Control1)
        {
            group(Control1102152012)
            {
                ShowCaption = false;
                grid(Control1102152011)
                {
                    ShowCaption = false;
                    group(Control1102152009)
                    {
                        ShowCaption = false;
                        field("xRec.COUNT"; xRec.COUNT)
                        {
                            ApplicationArea = All;
                        }
                    }
                    group(Control1102152008)
                    {
                        ShowCaption = false;
                        field(Color_QCflag; Color_QCflag)
                        {
                            Editable = false;
                            Style = Unfavorable;
                            StyleExpr = TRUE;
                            ApplicationArea = All;
                        }
                    }
                    group(Control1102152006)
                    {
                        ShowCaption = false;
                        field(Color_Attachment; Color_Attachment)
                        {
                            Editable = false;
                            Style = StrongAccent;
                            StyleExpr = TRUE;
                            ApplicationArea = All;
                        }
                    }
                    group(Control1102152001)
                    {
                        ShowCaption = false;
                        field(bom_status_running; bom_status_running)
                        {
                            Style = Favorable;
                            StyleExpr = TRUE;
                            ApplicationArea = All;
                        }
                    }
                    group(Control1102152018)
                    {
                        ShowCaption = false;
                        field(bom_status_old; bom_status_old)
                        {
                            Style = Subordinate;
                            StyleExpr = TRUE;
                            ApplicationArea = All;
                        }
                    }
                    group(Control1102152004)
                    {
                        ShowCaption = false;
                        field(Color_obsolete; Color_obsolete)
                        {
                            Editable = false;
                            Style = Ambiguous;
                            StyleExpr = TRUE;
                            ApplicationArea = All;
                        }
                    }
                }
            }
        }
    }
    actions
    {
        modify("Ledger E&ntries")
        {
            Promoted = false;
        }
        modify(Action16)
        {
            Promoted = true;
        }

        modify("Requisition Worksheet")
        {
            Promoted = true;
        }

        modify("Item Journal")
        {
            Promoted = true;
        }
        modify("Item Reclassification Journal")
        {
            Promoted = false;
        }
        modify("Item Tracing")
        {
            Promoted = false;
        }
        modify("Adjust Item Cost/Price")
        {
            Promoted = false;
        }
        modify("Adjust Cost - Item Entries")
        {
            Promoted = true;
        }

        modify("Inventory - List")
        {
            Promoted = false;
        }
        modify("Item Register - Quantity")
        {
            Promoted = false;
        }
        modify("Inventory - Transaction Detail")
        {
            Promoted = false;
        }
        modify("Inventory Availability")
        {
            Promoted = true;
        }
        modify(Status)
        {
            Promoted = false;
        }
        modify("Inventory - Availability Plan")
        {
            Promoted = false;
        }
        modify("Inventory Order Details")
        {
            Promoted = false;
        }
        modify("Inventory Purchase Orders")
        {
            Promoted = false;
        }
        modify("Inventory - Top 10 List")
        {
            Promoted = true;
        }
        modify("Inventory - Sales Statistics")
        {
            Promoted = false;
        }

        modify("Inventory - Customer Sales")
        {
            Promoted = false;
        }
        modify("Inventory - Vendor Purchases")
        {
            Promoted = false;
        }

        modify("Inventory Cost and Price List")
        {
            Promoted = true;
        }
        modify("Inventory - Reorders")
        {
            Promoted = true;
        }
        modify("Inventory - Sales Back Orders")
        {
            Promoted = true;
        }
        modify("Item/Vendor Catalog")
        {
            Promoted = false;
        }
        modify("Inventory - Cost Variance")
        {
            Promoted = false;
        }
        modify("Phys. Inventory List")
        {
            Promoted = false;
        }
        modify("Inventory Valuation")
        {
            Promoted = true;
        }

        modify("Item Substitutions")
        {
            Promoted = false;
        }
        modify("Invt. Valuation - Cost Spec.")
        {
            Promoted = false;
        }
        modify("Inventory Valuation - WIP")
        {
            Promoted = false;
        }
        modify("Item Register - Value")
        {
            Promoted = false;
        }
        modify("Item Charges - Specification")
        {
            Promoted = false;
        }

        modify("Item Age Composition - Value")
        {
            Promoted = false;
        }
        modify("Item Expiration - Quantity")
        {
            Promoted = false;
        }
        modify("Cost Shares Breakdown")
        {
            Promoted = false;
        }
        modify("Detailed Calculation")
        {
            Promoted = false;
        }
        modify("Rolled-up Cost Shares")
        {
            Promoted = false;
        }
        modify("Single-Level Cost Shares")
        {
            Promoted = false;
        }
        modify("Where-Used (Top Level)")
        {
            Promoted = false;
        }
        modify("Quantity Explosion of BOM")
        {
            Promoted = false;
        }
        modify("Compare List")
        {
            Promoted = false;
        }
        addafter(Structure)
        {
            action("Alternate Items")
            {
                Caption = 'Alternate Items';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    Alternate_items.SETRANGE(Alternate_items."Item No.", Rec."No.");
                    PAGE.RUN(60070, Alternate_items);
                end;
            }
        }
        addafter("Co&mments")
        {
            action("Item Specifications")
            {
                Caption = 'Item Specifications';
                RunObject = Page "Item Specification";
                RunPageLink = "Item No." = FIELD("No."), "Product Group Code" = FIELD("Product Group Code Cust"), "Item Category Code" = FIELD("Item Category Code"), "Item Sub Group Code" = FIELD("Item Sub Group Code"), "Item Sub Sub Group Code" = FIELD("Item Sub Sub Group Code");
                ApplicationArea = All;
            }
        }
        addafter("Stockkeepin&g Units")
        {
            action("Update CS IGC")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                var
                    //Window: DotNet "'Microsoft.VisualBasic, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a'.Microsoft.VisualBasic.Interaction" RUNONCLIENT;
                    CSIGC_Code: Code[20];
                    Window: Dotnet WindowVB;
                begin
                    // >>Added by Pranavi on 25-Apr-2017 for CS IGC Code updatation
                    CLEAR(CSIGC_Code);
                    /*
                    Window.OPEN('Please enter CS IGC code: ##############1##',CSIGC_Code);
                    Window.INPUT(1,CSIGC_Code);
                    MESSAGE(CSIGC_Code);
                    Window.CLOSE;
                    */
                    IF USERID IN ['EFFTRONICS\SRIVALLI', 'EFFTRONICS\PRANAVI'] THEN BEGIN
                        CSIGC_Code := Window.InputBox('Enter CS IGC Code:', 'INPUT', Rec."CS IGC", 100, 100);
                        IF (CSIGC_Code <> '') THEN BEGIN
                            IF (Rec."CS IGC" <> '') THEN BEGIN
                                IF (Rec."CS IGC" <> CSIGC_Code) THEN
                                    IF CONFIRM('Are You Sure to update the CS IGC code from ' + Rec."CS IGC" + ' to ' + CSIGC_Code + ' ?', FALSE) THEN BEGIN
                                        Rec."CS IGC" := CSIGC_Code;
                                        Rec.MODIFY;
                                    END;
                            END ELSE BEGIN
                                Rec."CS IGC" := CSIGC_Code;
                                Rec.MODIFY;
                            END;
                        END;
                    END ELSE
                        ERROR('You Do not have right to update CS IGC!');
                    // <<Added by Pranavi on 25-Apr-2017 for CS IGC Code updatation

                end;
            }
            action("Update BIN & Stock Address")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                var
                    /*
                     Prompt: DotNet "'System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Windows.Forms.Form" RUNONCLIENT;
                    FormBorderStyle: DotNet "'System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Windows.Forms.FormBorderStyle" RUNONCLIENT;
                    FormStartPosition: DotNet "'System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Windows.Forms.FormStartPosition" RUNONCLIENT;
                    
                    lblStockAddress: DotNet "'System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Windows.Forms.Label" RUNONCLIENT;
                    txtBINAddress: DotNet "'System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Windows.Forms.TextBox" RUNONCLIENT;
                    txtStockAddress: DotNet "'System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Windows.Forms.TextBox" RUNONCLIENT;
                    confirmation: DotNet "'System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Windows.Forms.Button" RUNONCLIENT;
                    DialogResult: DotNet "'System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Windows.Forms.DialogResult" RUNONCLIENT;
                    */
                    Prompt: DotNet PromptD;
                    FormBorderStyle: DotNet FormBorderStyleD;
                    FormStartPosition: DotNet FormStartPositionD;
                    lblIBINAddress: DotNet lblIBINAddressD;
                    lblStockAddress: DotNet lblStockAddressD;
                    txtBINAddress: DotNet txtBINAddressD;
                    txtStockAddress: DotNet txtStockAddressD;
                    confirmation: DotNet confirmationD;
                    DialogResult: DotNet DialogResultD;
                    BINAddress: Code[20];
                    StockAddress: Code[20];
                begin
                    //Creating the form
                    IF NOT (USERID IN ['EFFTRONICS\PRANAVI', 'EFFTRONICS\PADMASRI', 'EFFTRONICS\MARI', 'EFFTRONICS\VSNGEETHA']) THEN
                        ERROR('You Do not have rights to update BIN & Stock Address!');
                    Prompt := Prompt.Form();
                    Prompt.Width := 500;
                    Prompt.Height := 230;
                    Prompt.FormBorderStyle := FormBorderStyle.FixedDialog;

                    Prompt.Text := 'Enter BIN & Stock Address Details';
                    Prompt.StartPosition := FormStartPosition.CenterScreen;

                    //Creating the form
                    //Adding Labels

                    lblIBINAddress := lblIBINAddress.Label();
                    lblIBINAddress.Text('BIN Address :');
                    lblIBINAddress.Left(50);
                    lblIBINAddress.Top(20);
                    Prompt.Controls.Add(lblIBINAddress);

                    lblStockAddress := lblStockAddress.Label();
                    lblStockAddress.Text('Stock Address :');
                    lblStockAddress.Left(50);
                    lblStockAddress.Top(50);
                    Prompt.Controls.Add(lblStockAddress);

                    //Adding Labels
                    //adding text boxes, you can use other components like the dropdown list or a calendar, //or radio buttons

                    txtBINAddress := txtBINAddress.TextBox();
                    txtBINAddress.Left(180);
                    txtBINAddress.Top(20);
                    txtBINAddress.Width(150);
                    Prompt.Controls.Add(txtBINAddress);

                    txtStockAddress := txtStockAddress.TextBox();
                    txtStockAddress.Left(180);
                    txtStockAddress.Top(50);
                    txtStockAddress.Width(150);
                    Prompt.Controls.Add(txtStockAddress);

                    //adding text boxes
                    //adding submit button

                    confirmation := confirmation.Button();
                    confirmation.Text('OK');
                    confirmation.Left(180);
                    confirmation.Top(120);
                    confirmation.Width(150);
                    confirmation.DialogResult := DialogResult.OK;
                    Prompt.Controls.Add(confirmation);
                    Prompt.AcceptButton := confirmation;

                    //adding submit button

                    // Getting the Result
                    BINAddress := Rec."BIN Address";
                    StockAddress := Rec."Stock Address";
                    txtBINAddress.Text := Rec."BIN Address";
                    txtStockAddress.Text := Rec."Stock Address";
                    IF (Prompt.ShowDialog().ToString() = DialogResult.OK.ToString()) THEN BEGIN
                        IF (txtBINAddress.Text <> BINAddress) AND (BINAddress <> '') THEN BEGIN
                            IF CONFIRM('Are You Sure to update the BIN Address from ' + Rec."BIN Address" + ' to ' + txtBINAddress.Text + ' ?', FALSE) THEN BEGIN
                                Rec."BIN Address" := txtBINAddress.Text;
                                Rec.MODIFY;
                            END;
                        END ELSE
                            IF (txtBINAddress.Text <> BINAddress) AND (BINAddress = '') THEN BEGIN
                                Rec."BIN Address" := txtBINAddress.Text;
                                Rec.MODIFY;
                            END;
                        IF (txtStockAddress.Text <> StockAddress) AND (StockAddress <> '') THEN BEGIN
                            IF CONFIRM('Are You Sure to update the Stock Address from ' + Rec."Stock Address" + ' to ' + txtStockAddress.Text + ' ?', FALSE) THEN BEGIN
                                Rec."Stock Address" := txtStockAddress.Text;
                                Rec.MODIFY;
                            END;
                        END ELSE
                            IF (txtStockAddress.Text <> StockAddress) AND (StockAddress = '') THEN BEGIN
                                Rec."Stock Address" := txtStockAddress.Text;
                                Rec.MODIFY;
                            END;
                    END;

                    Prompt.Dispose();

                    // Getting the Result
                end;
            }
        }
        addafter("C&alculate Counting Period")
        {
            action("Show MCH Shortage Material")
            {
                Caption = 'Show MCH Shortage Material';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    Rec.RESET;
                    Rec.SETFILTER("Product Group Code Cust", '<>%1&%2', 'FPRODUCT', 'CPCB');
                    Rec.CALCFIELDS("Stock At MCH Location");
                    IF Rec.FINDSET THEN
                        REPEAT
                                IF Rec."Stock At MCH Location" < Rec."Safety Stock Qty (MCH)" THEN
                                    Rec.MARK := TRUE;
                        UNTIL Rec.NEXT = 0;
                    Rec.MARKEDONLY;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        //Added by Rakesh for Color indication of Items on 4-Apr-14
        //start
        Color_QCflag := 'Has QC Flag';
        Color_Attachment := 'Has Attachment';
        Color_obsolete := 'Is Obsolete';
        bom_status_running := 'Running Bom';
        bom_status_old := 'Old Bom';
        //End by Rakesh
    end;

    trigger OnAfterGetRecord()
    begin
        NoOnFormat;
        DescriptionOnFormat;
    end;



    var
        user: Record User;
        Alternate_items: Record "Alternate Items";
        IRH: Record "Inspection Receipt Header";
        [InDataSet]
        "No.Emphasize": Boolean;
        [InDataSet]
        DescriptionEmphasize: Boolean;
        Attachment: Record Attachments;
        "No.Format": Text;
        Color_QCflag: Text;
        Color_Attachment: Text;
        Color_obsolete: Text;
        bom_status_running: Text;
        bom_status_old: Text;
        PBH: Record "Production BOM Header";




    local procedure NoOnFormat();
    begin
        //Rev01 Begin
        IRH.RESET;
        IRH.SETCURRENTKEY("Item No.", Status, Flag);  //Rev01
        IRH.SETFILTER(IRH."Item No.", Rec."No.");
        IRH.SETRANGE(IRH.Status, TRUE);
        IRH.SETRANGE(IRH.Flag, TRUE);
        IF IRH.FINDFIRST THEN
            "No.Format" := 'Unfavorable'
        ELSE BEGIN
            "No.Format" := 'None';
            //"No.Emphasize" := NOT (IRH.ISEMPTY)
            //Rev01 End
            Attachment.RESET;
            Attachment.SETRANGE("Table ID", DATABASE::Item);
            Attachment.SETRANGE("Document No.", Rec."No.");
            Attachment.SETRANGE(Attachment."Attachment Status", TRUE);
            IF Attachment.FINDFIRST THEN BEGIN
                "No.Format" := 'StrongAccent';
                //"No.Emphasize" :='StrongAccent';
            END
            ELSE
                "No.Format" := 'None';
        END;
        PBH.RESET;
        PBH.SETFILTER("No.", Rec."No.");
        PBH.SETFILTER("BOM Running Status", 'Running');
        IF PBH.FINDSET THEN BEGIN
            IF PBH."BOM Running Status" = PBH."BOM Running Status"::Running THEN
                "No.Format" := 'Favorable'
            ELSE
                "No.Format" := 'None';
        END;
        PBH.RESET;
        PBH.SETFILTER("No.", Rec."No.");
        PBH.SETFILTER("BOM Running Status", 'Old');
        IF PBH.FINDSET THEN BEGIN
            IF PBH."BOM Running Status" = PBH."BOM Running Status"::Old THEN
                "No.Format" := 'Subordinate'
            ELSE
                "No.Format" := 'None';
        END;

    end;


    local procedure DescriptionOnFormat();
    begin
        IF FORMAT(Rec."Item Status") = 'Obsolete' THEN BEGIN
            DescriptionEmphasize := TRUE;
        END ELSE BEGIN
            DescriptionEmphasize := FALSE;
            //REV01
        END;
    end;
}

