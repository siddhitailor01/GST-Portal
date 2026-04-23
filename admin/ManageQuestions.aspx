<%@ Page Title="Question Bank | GST Admin" Language="C#" MasterPageFile="~/admin/adminMasterPage.master" AutoEventWireup="true" CodeFile="ManageQuestions.aspx.cs" Inherits="admin_ManageQuestions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        :root { --brand-primary: #6366f1; --brand-success: #10b981; }
        
        /* Tab Navigation Styling */
        .nav-tabs-premium { border: none; background: #f1f5f9; padding: 5px; border-radius: 15px; display: inline-flex; margin-bottom: 25px; }
        .nav-tabs-premium .nav-link { 
            border: none; color: #64748b; font-weight: 800; text-transform: uppercase; 
            font-size: 0.75rem; padding: 10px 25px; border-radius: 12px; transition: 0.3s;
        }
        .nav-tabs-premium .nav-link.active { background: white !important; color: var(--brand-primary) !important; box-shadow: 0 4px 12px rgba(0,0,0,0.05); }

        /* Fixed Scroll Area */
        .fixed-scroll-container { height: 500px; overflow-y: auto; padding-right: 10px; }
        .fixed-scroll-container::-webkit-scrollbar { width: 6px; }
        .fixed-scroll-container::-webkit-scrollbar-thumb { background: #e2e8f0; border-radius: 10px; }

        .luxury-card { background: white; border-radius: 30px; border: none; box-shadow: 0 20px 50px rgba(15, 23, 42, 0.05); overflow: hidden; padding: 35px; }
        .luxury-input { background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 15px; padding: 12px 18px; font-weight: 600; width: 100%; transition: 0.3s; }
        .luxury-input:focus { border-color: var(--brand-primary); background: white; outline: none; }

        .question-item { background: white; border: 1px solid #f1f5f9; border-radius: 20px; padding: 20px; margin-bottom: 15px; }
        .answer-pill { font-size: 0.7rem; font-weight: 800; padding: 4px 10px; border-radius: 8px; background: #dcfce7; color: #16a34a; border: 1px solid #bbf7d0; }
        .lvl-badge { font-size: 0.6rem; font-weight: 800; padding: 4px 10px; border-radius: 50px; text-transform: uppercase; margin-bottom: 8px; display: inline-block; }
        .lvl-1 { background: #dcfce7; color: #16a34a; } .lvl-2 { background: #e0f2fe; color: #0369a1; } .lvl-3 { background: #fef2f2; color: #b91c1c; }
        
        .btn-champion { background: #0f172a; color: white !important; border: none; border-radius: 15px; padding: 15px 35px; font-weight: 800; text-transform: uppercase; transition: 0.4s; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <div class="row mb-4 animate__animated animate__fadeIn">
        <div class="col-md-6">
            <h2 class="fw-900 text-slate-800 mb-1">Intelligence Hub</h2>
            <p class="text-muted small fw-bold mb-0">Rajasthan's Official GST Question Bank</p>
        </div>
        <div class="col-md-6 d-flex justify-content-end gap-3 align-items-center">
            <div class="badge bg-success-subtle text-success border border-success-subtle px-4 py-2 rounded-pill fw-bold">
                ACTIVE: <asp:Literal ID="litActiveCount" runat="server">0</asp:Literal>
            </div>
            <asp:LinkButton ID="btnShowInactive" runat="server" OnClick="btnShowInactive_Click" CssClass="badge bg-danger-subtle text-danger border border-danger-subtle px-4 py-2 rounded-pill fw-bold text-decoration-none">
                INACTIVE: <asp:Literal ID="litInactiveCount" runat="server">0</asp:Literal>
            </asp:LinkButton>
        </div>
    </div>

    <ul class="nav nav-tabs nav-tabs-premium shadow-sm" id="questionTabs" role="tablist">
        <li class="nav-item">
            <button class="nav-link active" id="add-tab" data-bs-toggle="tab" data-bs-target="#addContent" type="button" role="tab">
                <i class="fas fa-plus-circle me-2"></i>Draft New
            </button>
        </li>
        <li class="nav-item">
            <button class="nav-link" id="view-tab" data-bs-toggle="tab" data-bs-target="#viewContent" type="button" role="tab">
                <i class="fas fa-database me-2"></i>Question Bank
            </button>
        </li>
    </ul>

    <div class="tab-content" id="myTabContent">
    <div class="tab-pane fade show active" id="addContent" role="tabpanel">
        <div class="luxury-card animate__animated animate__fadeIn">
            <asp:UpdatePanel ID="upForm" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <asp:Label ID="lblMsg" runat="server" EnableViewState="false"></asp:Label>
                    <div class="row g-4">
                        <div class="col-md-4">
                            <label class="small fw-800 text-muted uppercase d-block mb-2">Complexity Tier</label>
                            <asp:DropDownList ID="ddlLevel" runat="server" CssClass="form-select luxury-input" AutoPostBack="true" OnSelectedIndexChanged="ddlLevel_SelectedIndexChanged">
                                <asp:ListItem Text="-- Select Level --" Value="0" />
                                <asp:ListItem Text="Level 1 - Basic" Value="1" />
                                <asp:ListItem Text="Level 2 - Practical" Value="2" />
                                <asp:ListItem Text="Level 3 - Advanced" Value="3" />
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-8">
                            <label class="small fw-800 text-muted uppercase d-block mb-2">Quiz Topic</label>
                            <asp:DropDownList ID="ddlTopic" runat="server" CssClass="form-select luxury-input" AppendDataBoundItems="true">
                                <asp:ListItem Text="-- Select Topic --" Value="0" />
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-12">
                            <label class="small fw-800 text-muted uppercase d-block mb-2">Question Text</label>
                            <asp:TextBox ID="txtQuestion" runat="server" CssClass="luxury-input" TextMode="MultiLine" Rows="2" placeholder="Sawal likhein..."></asp:TextBox>
                        </div>
                        <div class="col-md-3"><asp:TextBox ID="txtOptA" runat="server" CssClass="luxury-input" placeholder="Option A" /></div>
                        <div class="col-md-3"><asp:TextBox ID="txtOptB" runat="server" CssClass="luxury-input" placeholder="Option B" /></div>
                        <div class="col-md-3"><asp:TextBox ID="txtOptC" runat="server" CssClass="luxury-input" placeholder="Option C" /></div>
                        <div class="col-md-3"><asp:TextBox ID="txtOptD" runat="server" CssClass="luxury-input" placeholder="Option D" /></div>
                        
                        <div class="col-md-4">
                            <label class="small fw-800 text-success uppercase d-block mb-2">Correct Answer</label>
                            <asp:DropDownList ID="ddlCorrect" runat="server" CssClass="form-select luxury-input border-success">
                                <asp:ListItem Value="A" Text="A" /><asp:ListItem Value="B" Text="B" /><asp:ListItem Value="C" Text="C" /><asp:ListItem Value="D" Text="D" />
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-8">
                            <label class="small fw-800 text-muted uppercase d-block mb-2">Explanation</label>
                            <asp:TextBox ID="txtExplanation" runat="server" CssClass="luxury-input" placeholder="Explain why..."></asp:TextBox>
                        </div>
                        <div class="col-md-12 text-end">
                            <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-light rounded-pill px-4 me-2 fw-bold" OnClick="btnReset_Click" />
                            <asp:Button ID="btnSave" runat="server" Text="Deploy Question" CssClass="btn-champion shadow" OnClick="btnSave_Click" />
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div> 

    <div class="tab-pane fade" id="viewContent" role="tabpanel">
        <div class="luxury-card animate__animated animate__fadeIn">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h5 class="fw-900 mb-0">Live Repository</h5>
                <div class="position-relative">
                    <i class="fas fa-search position-absolute" style="left:15px; top:50%; transform:translateY(-50%); color:#94a3b8;"></i>
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="luxury-input py-1 ps-5" 
                        placeholder="Search sawal..." style="width:250px; font-size:0.8rem;"
                        AutoPostBack="true" OnTextChanged="txtSearch_TextChanged">
                    </asp:TextBox>
                </div>
            </div>

            <div class="fixed-scroll-container">
    <asp:UpdatePanel ID="upGrid" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:GridView ID="gvQuestions" runat="server" AutoGenerateColumns="False"
                CssClass="table table-borderless mb-0" DataKeyNames="QuestionID"
                OnRowCommand="gvQuestions_RowCommand" OnRowDeleting="gvQuestions_RowDeleting" ShowHeader="false">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <div class="question-item">
                                <div class="d-flex justify-content-between align-items-start mb-2">
                                    <asp:LinkButton ID="btnViewRow" runat="server" CommandName="VIEW_DETAILS" CommandArgument='<%# Eval("QuestionID") %>' CssClass="text-decoration-none flex-grow-1">
                                        <span class='lvl-badge lvl-<%# Eval("LevelID") %>'>L<%# Eval("LevelID") %>: <%# Eval("TopicName") %></span>
                                        <div class="fw-800 text-dark fs-6"><%# Eval("QuestionText") %></div>
                                    </asp:LinkButton>
                                    
                                    <div class="d-flex gap-2 ms-3">
                                        <asp:LinkButton ID="btnToggle" runat="server" CommandName="TOGGLE" CommandArgument='<%# Eval("QuestionID") %>' 
                                            CssClass="btn btn-sm btn-light rounded-pill border fw-bold" style="font-size:0.7rem;">
                                            <%# (Convert.ToBoolean(Eval("IsActive")) ? "Hide" : "Show") %>
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnDel" runat="server" CommandName="Delete" CssClass="text-danger pt-1" OnClientClick="return confirm('Bhai, delete kardein?');">
                                            <i class="fas fa-trash-alt"></i>
                                        </asp:LinkButton>
                                    </div>
                                </div>
                                <div class="d-flex gap-3 mt-1">
                                    <span class="answer-pill">Correct: <%# Eval("CorrectOption") %></span>
                                    <span class="small text-muted cursor-pointer"><i class="fas fa-eye me-1 text-primary"></i> Click text to view details</span>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <asp:Panel ID="pnlDetailsModal" runat="server" Visible="false" CssClass="modal fade show d-block" style="background:rgba(15,23,42,0.8); backdrop-filter:blur(10px); z-index:10001;">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content border-0 rounded-4 shadow-lg overflow-hidden">
                        <div class="modal-header border-0 p-4 bg-light">
                            <h5 class="fw-900 mb-0">Question Intelligence</h5>
                            <asp:LinkButton ID="btnCloseDetails" runat="server" OnClick="btnCloseDetails_Click" CssClass="btn-close shadow-none"></asp:LinkButton>
                        </div>
                        <div class="modal-body p-4">
                            <div class="mb-4">
                                <span class="small fw-800 text-muted uppercase">Statement</span>
                                <h5 class="fw-bold text-slate-800 mt-1"><asp:Literal ID="litDetQuestion" runat="server" /></h5>
                            </div>
                            <div class="row g-3 mb-4">
                                <div class="col-6"><div class="p-3 rounded border bg-light small"><b>A:</b> <asp:Literal ID="litDetA" runat="server" /></div></div>
                                <div class="col-6"><div class="p-3 rounded border bg-light small"><b>B:</b> <asp:Literal ID="litDetB" runat="server" /></div></div>
                                <div class="col-6"><div class="p-3 rounded border bg-light small"><b>C:</b> <asp:Literal ID="litDetC" runat="server" /></div></div>
                                <div class="col-6"><div class="p-3 rounded border bg-light small"><b>D:</b> <asp:Literal ID="litDetD" runat="server" /></div></div>
                            </div>
                            <div class="p-3 rounded-3 bg-success-subtle text-success mb-3 fw-bold border border-success-subtle">
                                <i class="fas fa-check-circle me-2"></i>CORRECT OPTION: <asp:Literal ID="litDetCorrect" runat="server" />
                            </div>
                            <div class="p-3 rounded-3 bg-indigo-subtle text-primary fw-bold border border-indigo-subtle">
                                <i class="fas fa-info-circle me-2"></i>EXPLANATION: <asp:Literal ID="litDetExp" runat="server" />
                            </div>
                        </div>
                    </div>
                </div>
            </asp:Panel>

        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="txtSearch" EventName="TextChanged" />
        </Triggers>
    </asp:UpdatePanel>
</div>
        </div>
    </div>
</div>





    <asp:Panel ID="pnlInactiveModal" runat="server" Visible="false" CssClass="modal fade show d-block" style="background:rgba(15,23,42,0.8); backdrop-filter:blur(10px); z-index:9999;">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content border-0 rounded-4 shadow-lg overflow-hidden">
                <div class="modal-header bg-danger text-white border-0 p-4">
                    <h5 class="fw-bold mb-0"><i class="fas fa-eye-slash me-2"></i>Deactivated Questions</h5>
                    <asp:LinkButton ID="btnCloseModal" runat="server" OnClick="btnCloseModal_Click" CssClass="btn-close btn-close-white shadow-none"></asp:LinkButton>
                </div>
                <div class="modal-body p-0" style="max-height: 450px; overflow-y: auto;">
                    <asp:GridView ID="gvInactive" runat="server" AutoGenerateColumns="false" CssClass="table table-hover mb-0" GridLines="None">
                        <Columns>
                            <asp:TemplateField HeaderText="Draft Details" ItemStyle-CssClass="p-4">
                                <ItemTemplate>
                                    <div class="small fw-800 text-danger mb-1"><%# Eval("TopicName") %></div>
                                    <div class="fw-bold text-dark"><%# Eval("QuestionText") %></div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Quick Action" ItemStyle-CssClass="p-4 text-end" ItemStyle-Width="180">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnQuickActivate" runat="server" OnClick="btnQuickActivate_Click" CommandArgument='<%# Eval("QuestionID") %>' CssClass="btn btn-sm btn-success rounded-pill px-4 fw-bold">Activate</asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle CssClass="bg-light small fw-bold text-muted text-uppercase p-3" />
                        <EmptyDataTemplate><div class="p-5 text-center text-muted fw-bold">Sab shant hai! Koi inactive sawaal nahi mila.</div></EmptyDataTemplate>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </asp:Panel>
</asp:Content>