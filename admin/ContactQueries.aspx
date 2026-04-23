<%@ Page Title="Manage Queries | GST Admin" Language="C#" MasterPageFile="~/admin/adminMasterPage.master" AutoEventWireup="true" CodeFile="ContactQueries.aspx.cs" Inherits="admin_ContactQueries" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        :root { --brand-primary: #6366f1; --brand-secondary: #a855f7; }
        .query-card { border-radius: 24px; border: none; background: white; box-shadow: 0 10px 30px rgba(15, 23, 42, 0.05); }
        
        /* Search & Filter Bar */
        .action-bar { background: #f8fafc; border-radius: 20px; padding: 20px; margin-bottom: 25px; border: 1px solid #e2e8f0; }
        .search-box { background: white; border-radius: 12px; border: 1px solid #e2e8f0; padding: 10px 20px 10px 45px; font-weight: 600; width: 100%; transition: 0.3s; }
        .search-box:focus { border-color: var(--brand-primary); box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.1); outline: none; }
        .search-icon { position: absolute; left: 30px; top: 50%; transform: translateY(-50%); color: #94a3b8; }

        /* Grid Styling */
        .grid-view-custom { border: none !important; margin-bottom: 0; }
        .grid-view-custom th { background: white; color: #64748b; padding: 20px; border-bottom: 2px solid #f1f5f9 !important; font-weight: 800; text-transform: uppercase; font-size: 0.7rem; letter-spacing: 1.5px; }
        .grid-view-custom td { padding: 20px; vertical-align: middle; border-bottom: 1px solid #f8fafc !important; font-size: 0.9rem; }
        
        .unread-row { background-color: #f0f7ff !important; border-left: 4px solid var(--brand-primary) !important; }
        .unread-row td { font-weight: 700; color: #1e293b; }
        
        .status-pill { padding: 6px 14px; border-radius: 50px; font-size: 0.65rem; font-weight: 800; text-transform: uppercase; letter-spacing: 0.5px; }
        .type-tag { padding: 4px 10px; border-radius: 8px; font-size: 0.7rem; font-weight: 700; background: #f1f5f9; color: #475569; }

        /* Modal Glassmorphism */
        .modal-glass { background: rgba(15, 23, 42, 0.6); backdrop-filter: blur(8px); }
        .modal-content-custom { border-radius: 30px; border: none; box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5); }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row mb-4">
        <div class="col-md-12 d-flex justify-content-between align-items-center">
            <div>
                <h3 class="fw-900 mb-1">Inquiry Inbox</h3>
                <p class="text-muted mb-0">Total <asp:Literal ID="litTotal" runat="server"></asp:Literal> messages received from Bhilwara users.</p>
            </div>
            <asp:LinkButton ID="btnRefresh" runat="server" OnClick="btnRefresh_Click" CssClass="btn btn-white shadow-sm rounded-pill px-4 fw-bold border">
                <i class="fas fa-sync-alt me-2 text-primary"></i> Refresh List
            </asp:LinkButton>
        </div>
    </div>

    <div class="action-bar shadow-sm">
        <div class="row g-3 align-items-center">
            <div class="col-md-6 position-relative">
                <i class="fas fa-search search-icon"></i>
                <asp:TextBox ID="txtSearch" runat="server" CssClass="search-box" placeholder="Search by name or subject..." AutoPostBack="true" OnTextChanged="txtSearch_TextChanged"></asp:TextBox>
            </div>
            <div class="col-md-3">
                <asp:DropDownList ID="ddlFilterType" runat="server" CssClass="form-select border-0 rounded-3 shadow-sm py-2 fw-bold" AutoPostBack="true" OnSelectedIndexChanged="ddlFilterType_SelectedIndexChanged">
                    <asp:ListItem Value="All">All Categories</asp:ListItem>
                    <asp:ListItem Value="General">General Inquiry</asp:ListItem>
                    <asp:ListItem Value="Topic Doubt">Topic Doubts</asp:ListItem>
                    <asp:ListItem Value="Feedback">Feedback</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col-md-3 text-end">
                <div class="badge bg-warning text-dark px-3 py-2 rounded-pill fw-bold">
                    <i class="fas fa-bolt me-1"></i> <asp:Literal ID="litUnreadCount" runat="server">0</asp:Literal> New
                </div>
            </div>
        </div>
    </div>

    <div class="card query-card shadow-sm">
        <div class="card-body p-0">
            <asp:GridView ID="gvQueries" runat="server" AutoGenerateColumns="False" 
                CssClass="table grid-view-custom mb-0" DataKeyNames="MessageID" 
                OnRowCommand="gvQueries_RowCommand" OnRowDataBound="gvQueries_RowDataBound">
                <Columns>
                    <asp:TemplateField HeaderText="Inquiry Details">
                        <ItemTemplate>
                            <div class="d-flex align-items-center">
                                <div class="avatar-circle me-3 bg-light text-primary rounded-circle d-flex align-items-center justify-content-center" style="width:40px;height:40px;">
                                    <%# Eval("FullName").ToString().Substring(0,1).ToUpper() %>
                                </div>
                                <div>
                                    <div class="fw-bold text-dark"><%# Eval("FullName") %></div>
                                    <div class="small text-muted"><%# Eval("CreatedDate", "{0:dd MMM, hh:mm tt}") %></div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Topic & Category">
                        <ItemTemplate>
                            <div class="mb-1"><span class="type-tag"><%# Eval("InquiryType") %></span></div>
                            <div class="small fw-bold text-secondary"><%# Eval("Subject") %></div>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Status" ItemStyle-Width="120">
                        <ItemTemplate>
                            <span class='status-pill <%# Convert.ToBoolean(Eval("IsRead")) ? "bg-success-subtle text-success" : "bg-danger-subtle text-danger" %>'>
                                <%# Convert.ToBoolean(Eval("IsRead")) ? "Read" : "Pending" %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Actions" ItemStyle-Width="130">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnView" runat="server" CommandName="ViewMessage" CommandArgument='<%# Eval("MessageID") %>' CssClass="btn btn-light btn-sm rounded-3 me-1 border" ToolTip="Read Message">
                                <i class="fas fa-envelope-open text-primary"></i>
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteMessage" CommandArgument='<%# Eval("MessageID") %>' OnClientClick="return confirm('Bhai, pakka delete karna hai?');" CssClass="btn btn-light btn-sm rounded-3 border" ToolTip="Delete">
                                <i class="fas fa-trash-alt text-danger"></i>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="text-center py-5">
                        <img src="https://illustrations.popsy.co/blue/empty-folder.svg" style="width:180px" class="mb-3 opacity-50" />
                        <h5 class="text-muted fw-bold">Inbox is clean! No queries found.</h5>
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>

    <asp:Panel ID="pnlModal" runat="server" Visible="false" CssClass="modal fade show d-block modal-glass">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content modal-content-custom shadow-lg">
                <div class="modal-header border-0 p-4 pb-0">
                    <h5 class="fw-900 mb-0"><i class="fas fa-paper-plane text-primary me-2"></i>Message Content</h5>
                    <asp:LinkButton ID="btnClose" runat="server" OnClick="btnClose_Click" CssClass="btn-close"></asp:LinkButton>
                </div>
                <div class="modal-body p-4">
                    <div class="p-4 bg-light rounded-4 mb-4 border border-white">
                        <div class="small uppercase text-muted fw-bold mb-1">From:</div>
                        <div class="fw-bold text-dark fs-5"><asp:Literal ID="litModalName" runat="server"></asp:Literal></div>
                        <div class="text-primary small fw-bold"><asp:Literal ID="litModalEmail" runat="server"></asp:Literal></div>
                    </div>
                    <div class="mb-4">
                        <label class="small fw-800 text-muted uppercase">Subject:</label>
                        <p class="fw-bold text-dark border-bottom pb-2"><asp:Literal ID="litModalSubject" runat="server"></asp:Literal></p>
                    </div>
                    <div class="message-body p-4 rounded-4 bg-white border" style="min-height:150px; line-height:1.8;">
                        <asp:Literal ID="litModalBody" runat="server"></asp:Literal>
                    </div>
                </div>
                <div class="modal-footer border-0 p-4 pt-0">
                    <asp:Button ID="btnMarkRead" runat="server" Text="Mark as Processed" CssClass="btn btn-dark w-100 rounded-3 py-3 fw-bold shadow" OnClick="btnMarkRead_Click" />
                </div>
            </div>
        </div>
    </asp:Panel>
</asp:Content>