xmlport 80111 "QC setup"
{
    Format = VariableText;

    schema
    {
        textelement(QualityControlSetup)
        {
            tableelement("<qcsetup>"; "Quality Control Setup")
            {
                XmlName = 'QCSetup';
                fieldelement(PrimaryKey; "<QCSetup>"."Primary Key")
                {
                }
                fieldelement(SpecificationNos; "<QCSetup>"."Specification Nos.")
                {
                }
                fieldelement(InspectionDatasheetNos; "<QCSetup>"."Inspection Datasheet Nos.")
                {
                }
                fieldelement(PostedInspectDatasheetNos; "<QCSetup>"."Posted Inspect. Datasheet Nos.")
                {
                }
                fieldelement(InspectionReceiptNos; "<QCSetup>"."Inspection Receipt Nos.")
                {
                }
                fieldelement(SamplingPlanWarning; "<QCSetup>"."Sampling Plan Warning")
                {
                }
                fieldelement(InvoiceAfterInspectionOnly; "<QCSetup>"."Invoice After Inspection Only")
                {
                }
                fieldelement(SamplingRounding; "<QCSetup>"."Sampling Rounding")
                {
                }
                fieldelement(ProductionBatchNo; "<QCSetup>"."Production Batch No.")
                {
                }
                fieldelement(SubAssemblyNos; "<QCSetup>"."Sub Assembly Nos.")
                {
                }
                fieldelement(RatingPerAcceptedQty; "<QCSetup>"."Rating Per Accepted Qty.")
                {
                }
                fieldelement(RatingPerAcceptedUDQty; "<QCSetup>"."Rating Per Accepted UD Qty.")
                {
                }
                fieldelement(RatingPerReworkQty; "<QCSetup>"."Rating Per Rework Qty.")
                {
                }
                fieldelement(RatingPerRejectedQty; "<QCSetup>"."Rating Per Rejected Qty.")
                {
                }
                fieldelement(QualityBeforeReceipt; "<QCSetup>"."Quality Before Receipt")
                {
                }
                fieldelement(PurchaseConsignmentNo; "<QCSetup>"."Purchase Consignment No.")
                {
                }
                fieldelement(AssayNos; "<QCSetup>"."Assay Nos.")
                {
                }
                fieldelement(PostedIDSNoIsIDSNo; "<QCSetup>"."Posted IDS. No. Is IDS No.")
                {
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }
}

