<%@ Page Title="Manage FAQs | GST Admin" Language="C#" MasterPageFile="~/admin/adminMasterPage.master" AutoEventWireup="true" CodeFile="ManageFAQs.aspx.cs" Inherits="admin_ManageFAQs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        :root { --brand-primary: #6366f1; --brand-info: #0ea5e9; --bg-main: #f8fafc; }
        
        body { background-color: var(--bg-main); }

        /* Workspace Reset */
        .admin-workspace { 
            display: grid; 
            grid-template-columns: 1fr 400px; 
            gap: 30px; 
            height: calc(100vh - 120px); 
            padding-bottom: 20px;
        }

        /* --- Left: Modern Feed List --- */
        .list-container { 
            background: white; 
            border-radius: 40px; 
            display: flex; 
            flex-direction: column; 
            border: 1px solid rgba(0,0,0,0.03);
            box-shadow: 0 10px 40px rgba(0,0,0,0.02);
            overflow: hidden;
        }

        .list-header { padding: 30px; border-bottom: 1px solid #f1f5f9; }
        .scroll-feed { flex: 1; overflow-y: auto; padding: 0 30px 30px; }

        /* Customizing GridView to look like a Feed */
        .feed-grid { border: none !important; }
        .feed-grid tr { display: block; margin-bottom: 15px; border-radius: 20px; transition: 0.3s; border: 1px solid transparent; }
        .feed-grid tr:hover { background: #f8faff; border-color: #e0e7ff; transform: scale(1.01); }
        .feed-grid td { display: block; padding: 20px; border: none !important; }

        .category-tag { 
            font-size: 0.65rem; font-weight: 800; text-transform: uppercase; 
            padding: 4px 12px; border-radius: 10px; background: #e0e7ff; color: #4338ca;
            letter-spacing: 1px; margin-bottom: 10px; display: inline-block;
        }

        .question-text { font-size: 1.1rem; font-weight: 800; color: #1e293b; margin-bottom: 8px; }
        .answer-text { font-size: 0.9rem; color: #64748b; line-height: 1.6; }

        /* --- Right: Floating Editor Card --- */
        .editor-container { 
            background: #ffffff; 
            border-radius: 40px; 
            padding: 35px; 
            border: 1px solid rgba(0,0,0,0.05);
            box-shadow: 0 20px 50px rgba(0,0,0,0.05);
            display: flex; flex-direction: column;
        }

        .luxury-label { font-size: 0.75rem; font-weight: 800; color: #94a3b8; text-transform: uppercase; margin-bottom: 8px; margin-left: 5px; }
        
        .premium-input { 
            background: #f1f5f9; border: 2px solid transparent; border-radius: 18px; 
            padding: 14px 20px; font-weight: 600; color: #1e293b; width: 100%; transition: 0.3s;
            margin-bottom: 20px;
        }
        .premium-input:focus { background: white; border-color: var(--brand-primary); box-shadow: 0 10px 20px rgba(99, 102, 241, 0.1); outline: none; }

        .btn-champion {
            background: #0f172a; color: white !important; border: none; border-radius: 18px;
            padding: 18px; font-weight: 800; text-transform: uppercase; letter-spacing: 1px;
            transition: 0.4s; width: 100%; margin-top: 10px;
        }
        .btn-champion:hover { background: var(--brand-primary); transform: translateY(-5px); box-shadow: 0 15px 30px rgba(99, 102, 241, 0.3); }

        /* Action Buttons */
        .action-link { color: #94a3b8; font-size: 0.9rem; margin-left: 15px; transition: 0.3s; text-decoration: none; }
        .action-link:hover { color: var(--brand-primary); }
        .delete-link:hover { color: #ef4444; }

        /* Scrollbar */
        .scroll-feed::-webkit-scrollbar { width: 5px; }
        .scroll-feed::-webkit-scrollbar-thumb { background: #e2e8f0; border-radius: 10px; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row align-items-center mb-4">
        <div class="col-md-6">
            <h2 class="fw-900 text-slate-800 mb-0">Help Desk</h2>
            <p class="text-muted small fw-bold mb-0">Champion's Knowledge Base Management</p>
        </div>
        <div class="col-md-6 text-end">
             <div class="d-inline-flex bg-white rounded-pill p-1 shadow-sm border">
                <asp:TextBox ID="txtSearch" runat="server" CssClass="border-0 bg-transparent px-3 py-1 fw-600" placeholder="Search..." style="outline:none;"></asp:TextBox>
                <asp:LinkButton ID="btnSearch" runat="server" OnClick="btnSearch_Click" CssClass="btn btn-primary rounded-pill px-4 btn-sm fw-bold">Find</asp:LinkButton>
             </div>
        </div>
    </div>

    <div class="admin-workspace">
        <div class="list-container">
            <div class="list-header d-flex justify-content-between">
                <h5 class="fw-900 mb-0">Live Solutions</h5>
                <span class="badge bg-indigo-subtle text-primary rounded-pill px-3">Bhilwara Portal</span>
            </div>

            <div class="scroll-feed">
                <asp:GridView ID="gvFAQs" runat="server" AutoGenerateColumns="False" 
                    CssClass="table feed-grid" DataKeyNames="FAQID" 
                    OnRowDeleting="gvFAQs_RowDeleting" OnRowEditing="gvFAQs_RowEditing" 
                    OnRowUpdating="gvFAQs_RowUpdating" OnRowCancelingEdit="gvFAQs_RowCancelingEdit" ShowHeader="false">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <div class="d-flex justify-content-between align-items-start">
                                    <div>
                                        <span class="category-tag"><%# Eval("Category") %></span>
                                        <div class="question-text"><%# Eval("Question") %></div>
                                        <div class="answer-text"><%# Eval("Answer") %></div>
                                    </div>
                                    <div class="d-flex align-items-center pt-2">
                                        <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" CssClass="action-link"><i class="fas fa-pen-nib"></i></asp:LinkButton>
                                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CssClass="action-link delete-link" OnClientClick="return confirm('Hata dein?');"><i class="fas fa-trash-alt"></i></asp:LinkButton>
                                    </div>
                                </div>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <div class="p-2 bg-white rounded-4 border border-primary">
                                    <asp:TextBox ID="txtEditQ" runat="server" Text='<%# Bind("Question") %>' CssClass="premium-input mb-2"></asp:TextBox>
                                    <asp:TextBox ID="txtEditA" runat="server" Text='<%# Bind("Answer") %>' TextMode="MultiLine" Rows="3" CssClass="premium-input"></asp:TextBox>
                                    <div class="text-end">
                                        <asp:LinkButton ID="btnUpdate" runat="server" CommandName="Update" CssClass="btn btn-primary btn-sm rounded-pill px-4">Update</asp:LinkButton>
                                        <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel" CssClass="btn btn-light btn-sm rounded-pill px-4">Cancel</asp:LinkButton>
                                    </div>
                                </div>
                            </EditItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>

        <div class="editor-container">
            <div class="text-center mb-4">
                <div class="brand-icon bg-indigo-subtle text-primary rounded-circle d-inline-flex align-items-center justify-content-center mb-3" style="width:60px; height:60px;">
                    <i class="fas fa-plus fa-lg"></i>
                </div>
                <h5 class="fw-900 text-dark">Add New FAQ</h5>
                <p class="text-muted small">Update your users with latest GST laws</p>
            </div>

            <label class="luxury-label">Category</label>
            <asp:DropDownList ID="ddlCategory" runat="server" CssClass="premium-input">
                <asp:ListItem>General GST</asp:ListItem>
                <asp:ListItem>Registration</asp:ListItem>
                <asp:ListItem>Returns & Filing</asp:ListItem>
                <asp:ListItem>Legal & Penalties</asp:ListItem>
            </asp:DropDownList>

            <label class="luxury-label">Question</label>
            <asp:TextBox ID="txtQuestion" runat="server" CssClass="premium-input" placeholder="What is your query?"></asp:TextBox>

            <label class="luxury-label">Detailed Answer</label>
            <asp:TextBox ID="txtAnswer" runat="server" CssClass="premium-input" TextMode="MultiLine" Rows="6" placeholder="Provide accurate details..."></asp:TextBox>

            <asp:Button ID="btnSaveFAQ" runat="server" Text="Save Solution" CssClass="btn-champion shadow-lg" OnClick="btnSaveFAQ_Click" />
            
            <div class="mt-auto p-4 rounded-4 bg-light text-center">
                <p class="small text-muted mb-0"><i class="fas fa-shield-halved me-2 text-primary"></i> Secure Admin Access Active</p>
            </div>
        </div>
    </div>
</asp:Content>