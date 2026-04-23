<%@ Page Title="Topics Manager | GST Admin" Language="C#" MasterPageFile="~/admin/adminMasterPage.master" AutoEventWireup="true" CodeFile="ManageTopics.aspx.cs" Inherits="admin_ManageTopics" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        :root { --slate-50: #f8fafc; --slate-200: #e2e8f0; --slate-800: #1e293b; --primary: #2563eb; }
        body { background-color: #fcfcfd; font-family: 'Segoe UI', sans-serif; }

        /* Title Area */
        .admin-header { border-bottom: 1px solid var(--slate-200); padding-bottom: 20px; margin-bottom: 30px; }
        .admin-header h4 { color: var(--slate-800); font-weight: 700; }

        /* Professional Form Card */
        .form-panel { background: #ffffff; border: 1px solid var(--slate-200); border-radius: 12px; box-shadow: 0 1px 3px rgba(0,0,0,0.05); }
        .panel-header { padding: 15px 25px; border-bottom: 1px solid var(--slate-200); background-color: var(--slate-50); border-radius: 12px 12px 0 0; }
        .panel-header span { font-weight: 700; font-size: 0.9rem; color: var(--slate-800); text-transform: uppercase; }
        
        .form-content { padding: 25px; }
        .field-label { font-size: 0.85rem; font-weight: 600; color: #475569; margin-bottom: 8px; display: block; }
        
        .standard-input { 
            border: 1px solid var(--slate-200); border-radius: 8px; padding: 10px 15px; width: 100%; 
            font-size: 0.95rem; color: var(--slate-800); transition: border-color 0.2s;
        }
        .standard-input:focus { border-color: var(--primary); outline: none; box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1); }

        /* Modern Grid Table */
        .table-panel { background: #ffffff; border: 1px solid var(--slate-200); border-radius: 12px; overflow: hidden; margin-top: 30px; }
        .gv-topics { width: 100%; border-collapse: collapse; }
        .gv-topics th { 
            background: var(--slate-50); padding: 15px 20px; color: #64748b; font-weight: 700; 
            text-align: left; font-size: 0.8rem; text-transform: uppercase; letter-spacing: 0.025em;
        }
        .gv-topics td { padding: 16px 20px; border-top: 1px solid var(--slate-200); color: var(--slate-800); vertical-align: middle; }
        .gv-topics tr:hover { background-color: #f9fafb; }

        /* Flat Level Indicator */
        .level-text { font-weight: 700; font-size: 0.85rem; padding-left: 8px; border-left: 3px solid var(--slate-200); }
        .lvl-blue { border-color: #3b82f6; color: #1d4ed8; }
        .lvl-green { border-color: #10b981; color: #047857; }
        .lvl-red { border-color: #ef4444; color: #b91c1c; }

        /* Solid Buttons */
        .btn-action { 
            background-color: var(--slate-800); color: #fff !important; border: none; border-radius: 8px; 
            padding: 10px 24px; font-weight: 600; font-size: 0.9rem; transition: background 0.2s;
        }
        .btn-action:hover { background-color: #000; }

        /* Grid Action Link Buttons */
        .gv-topics a { text-decoration: none; font-weight: 600; font-size: 0.85rem; margin-right: 15px; color: var(--primary); }
        .gv-topics a:hover { text-decoration: underline; }
        .gv-topics .del-btn { color: #ef4444; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <div class="admin-header">
        <h4 class="mb-1">Quiz Topics</h4>
        <p class="text-muted small mb-0">Define the difficulty levels and syllabus categories for student evaluations.</p>
    </div>

    <div class="form-panel">
        <div class="panel-header">
            <span>Add New Category</span>
        </div>
        <div class="form-content">
            <div class="row g-4">
                <div class="col-md-4">
                    <label class="field-label">Intelligence Level</label>
                    <asp:DropDownList ID="ddlLevel" runat="server" CssClass="form-select standard-input">
                        <asp:ListItem Text="Level 1 - Basic" Value="1"></asp:ListItem>
                        <asp:ListItem Text="Level 2 - Practical" Value="2"></asp:ListItem>
                        <asp:ListItem Text="Level 3 - Advanced" Value="3"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-5">
                    <label class="field-label">Name of Topic</label>
                    <asp:TextBox ID="txtTopicName" runat="server" CssClass="standard-input" placeholder="e.g. Refund Processes"></asp:TextBox>
                </div>
                <div class="col-md-3 d-flex align-items-end">
                    <asp:Button ID="btnAddTopic" runat="server" Text="Register Topic" CssClass="btn-action w-100" OnClick="btnAddTopic_Click" />
                </div>
            </div>
        </div>
    </div>

    <div class="table-panel">
        <asp:GridView ID="gvTopics" runat="server" AutoGenerateColumns="False" 
            CssClass="gv-topics" DataKeyNames="TopicID" 
            OnRowEditing="gvTopics_RowEditing" OnRowDeleting="gvTopics_RowDeleting" 
            OnRowCancelingEdit="gvTopics_RowCancelingEdit" OnRowUpdating="gvTopics_RowUpdating" GridLines="None">
            
            <Columns>
                <asp:BoundField DataField="TopicID" HeaderText="ID" ReadOnly="True" ItemStyle-Width="10%" />
                
                <asp:TemplateField HeaderText="Difficulty Level" ItemStyle-Width="25%">
                    <ItemTemplate>
                        <span class='level-text <%# Eval("LevelID").ToString() == "1" ? "lvl-green" : (Eval("LevelID").ToString() == "2" ? "lvl-blue" : "lvl-red") %>'>
                            Level <%# Eval("LevelID") %>
                        </span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList ID="ddlEditLevel" runat="server" SelectedValue='<%# Bind("LevelID") %>' CssClass="form-select standard-input" style="padding: 5px;">
                            <asp:ListItem Value="1">Level 1</asp:ListItem>
                            <asp:ListItem Value="2">Level 2</asp:ListItem>
                            <asp:ListItem Value="3">Level 3</asp:ListItem>
                        </asp:DropDownList>
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Topic Information">
                    <ItemTemplate>
                        <span style="font-weight: 600;"><%# Eval("TopicName") %></span>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtEditTopicName" runat="server" Text='<%# Bind("TopicName") %>' CssClass="standard-input" style="padding: 5px;"></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" 
                    ButtonType="Link" HeaderText="Actions"
                    ItemStyle-CssClass="text-end pe-4" ControlStyle-CssClass="text-decoration-none fw-bold" />
            </Columns>

            <EmptyDataTemplate>
                <div class="p-5 text-center text-muted">
                    Inventory is empty. Please add a new topic to begin.
                </div>
            </EmptyDataTemplate>
        </asp:GridView>
    </div>
</asp:Content>