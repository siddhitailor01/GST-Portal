<%@ Page Title="Manage GST Rates" Language="C#" MasterPageFile="~/admin/adminMasterPage.master" AutoEventWireup="true" CodeFile="ManageRates.aspx.cs" Inherits="admin_ManageRates" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row mb-4">
        <div class="col-md-12 d-flex justify-content-between align-items-center">
            <div>
                <h4 class="fw-bold"><i class="fas fa-tags me-2 text-primary"></i>Manage GST Rates & HSN</h4>
                <p class="text-muted mb-0">HSN/SAC codes manage aur search karein.</p>
            </div>
            <div class="d-flex shadow-sm" style="max-width: 300px;">
                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control border-end-0" placeholder="Search HSN/Desc..."></asp:TextBox>
                <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-primary" OnClick="btnSearch_Click">
                    <i class="fas fa-search"></i>
                </asp:LinkButton>
            </div>
        </div>
    </div>

    <div class="card shadow-sm mb-4 border-0">
        <div class="card-header bg-white fw-bold py-3">Add New HSN/SAC Entry</div>
        <div class="card-body">
            <div class="row g-3">
                <div class="col-md-2">
                    <label class="form-label small fw-bold">HSN/SAC Code</label>
                    <asp:TextBox ID="txtHSN" runat="server" CssClass="form-control" placeholder="e.g. 8471"></asp:TextBox>
                </div>
                <div class="col-md-3">
                    <label class="form-label small fw-bold">Item Description</label>
                    <asp:TextBox ID="txtDesc" runat="server" CssClass="form-control" placeholder="e.g. Laptop"></asp:TextBox>
                </div>
                <div class="col-md-2">
                    <label class="form-label small fw-bold">Tax Rate</label>
                    <asp:DropDownList ID="ddlTax" runat="server" CssClass="form-select">
                        <asp:ListItem Value="0">0%</asp:ListItem>
                        <asp:ListItem Value="5">5%</asp:ListItem>
                        <asp:ListItem Value="12">12%</asp:ListItem>
                        <asp:ListItem Value="18" Selected="True">18%</asp:ListItem>
                        <asp:ListItem Value="28">28%</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-2">
                    <label class="form-label small fw-bold">Category</label>
                    <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-select">
                        <asp:ListItem Value="Goods">Goods</asp:ListItem>
                        <asp:ListItem Value="Services">Services</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-3 d-flex align-items-end">
                    <asp:Button ID="btnSaveRate" runat="server" Text="Save Entry" CssClass="btn btn-primary w-100" OnClick="btnSaveRate_Click" />
                </div>
            </div>
        </div>
    </div>

    <div class="card shadow-sm border-0">
        <div class="card-body p-0">
            <asp:GridView ID="gvRates" runat="server" AutoGenerateColumns="False" CssClass="table table-hover mb-0" 
                DataKeyNames="RateID" OnRowDeleting="gvRates_RowDeleting" OnRowEditing="gvRates_RowEditing" 
                OnRowUpdating="gvRates_RowUpdating" OnRowCancelingEdit="gvRates_RowCancelingEdit" OnRowDataBound="gvRates_RowDataBound">
                <Columns>
                    <asp:TemplateField HeaderText="HSN/SAC">
                        <ItemTemplate><%# Eval("HSNCode") %></ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEditHSN" runat="server" Text='<%# Bind("HSNCode") %>' CssClass="form-control form-control-sm"></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Description">
                        <ItemTemplate><%# Eval("Description") %></ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEditDesc" runat="server" Text='<%# Bind("Description") %>' CssClass="form-control form-control-sm"></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Rate">
                        <ItemTemplate>
                            <span class="badge bg-info-subtle text-info px-3"><%# Eval("TaxRate") %>%</span>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlEditTax" runat="server" CssClass="form-select form-select-sm"></asp:DropDownList>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Category">
                        <ItemTemplate><%# Eval("Category") %></ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlEditCategory" runat="server" CssClass="form-select form-select-sm">
                                <asp:ListItem Value="Goods">Goods</asp:ListItem>
                                <asp:ListItem Value="Services">Services</asp:ListItem>
                            </asp:DropDownList>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" CssClass="btn btn-sm btn-outline-primary"><i class="fas fa-edit"></i></asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CssClass="btn btn-sm btn-outline-danger" OnClientClick="return confirm('Delete?');"><i class="fas fa-trash"></i></asp:LinkButton>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:LinkButton ID="btnUpdate" runat="server" CommandName="Update" CssClass="btn btn-sm btn-success">Update</asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel" CssClass="btn btn-sm btn-secondary">Cancel</asp:LinkButton>
                        </EditItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle CssClass="table-light" />
            </asp:GridView>
        </div>
    </div>
</asp:Content>