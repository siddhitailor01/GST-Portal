<%@ Page Title="Quiz Settings | GST Admin" Language="C#" MasterPageFile="~/admin/adminMasterPage.master" AutoEventWireup="true" CodeFile="QuizSettings.aspx.cs" Inherits="admin_QuizSettings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        :root { --slate-50: #f8fafc; --slate-200: #e2e8f0; --slate-800: #1e293b; --brand-indigo: #4f46e5; }
        body { background-color: #fcfcfd; }

        /* Header Styling */
        .admin-header { border-bottom: 1px solid var(--slate-200); padding-bottom: 20px; margin-bottom: 30px; }
        .admin-header h4 { color: var(--slate-800); font-weight: 800; letter-spacing: -0.5px; }

        /* Professional Control Panel */
        .settings-panel { background: #ffffff; border: 1px solid var(--slate-200); border-radius: 16px; box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05); overflow: hidden; }
        .panel-title { padding: 20px 25px; border-bottom: 1px solid var(--slate-200); background-color: var(--slate-50); }
        .panel-title span { font-weight: 800; font-size: 0.85rem; color: var(--slate-800); text-transform: uppercase; letter-spacing: 1px; }
        
        .panel-body { padding: 30px; }
        .setting-label { font-size: 0.8rem; font-weight: 700; color: #64748b; text-transform: uppercase; margin-bottom: 10px; display: block; letter-spacing: 0.5px; }
        
        .modern-input { 
            border: 1px solid var(--slate-200); border-radius: 10px; padding: 12px 16px; width: 100%; 
            font-size: 0.95rem; font-weight: 600; color: var(--slate-800); transition: 0.3s ease;
            background: var(--slate-50);
        }
        .modern-input:focus { border-color: var(--brand-indigo); background: white; outline: none; box-shadow: 0 0 0 4px rgba(79, 70, 229, 0.1); }

        /* Info Card */
        .info-panel { background: #eff6ff; border: 1px solid #dbeafe; border-radius: 16px; height: 100%; }
        .info-panel-body { padding: 30px; }
        .info-panel h5 { color: #1e40af; font-weight: 800; font-size: 1rem; margin-bottom: 20px; }
        
        .info-list { list-style: none; padding: 0; }
        .info-list li { position: relative; padding-left: 30px; margin-bottom: 18px; color: #3b82f6; font-size: 0.9rem; font-weight: 500; line-height: 1.5; }
        .info-list li i { position: absolute; left: 0; top: 3px; font-size: 1rem; }
        .info-list b { color: #1e3a8a; }

        /* Solid Action Button */
        .btn-update { 
            background-color: var(--slate-800); color: #fff !important; border: none; border-radius: 12px; 
            padding: 14px; font-weight: 800; text-transform: uppercase; transition: 0.4s; letter-spacing: 1px;
            font-size: 0.85rem; margin-top: 10px;
        }
        .btn-update:hover { background-color: var(--brand-indigo); transform: translateY(-2px); box-shadow: 0 10px 20px rgba(79, 70, 229, 0.2); }
        
        .input-group-text { background: transparent; border-radius: 10px; border-color: var(--slate-200); font-weight: 800; color: #94a3b8; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <div class="admin-header animate__animated animate__fadeIn">
        <h4 class="mb-1"><i class="fas fa-sliders-h me-2 text-indigo-600"></i>Exam Parameters</h4>
        <p class="text-muted small mb-0 uppercase tracking-widest fw-bold">Configure Logic & Validation Rules for Practice Tests</p>
    </div>

    <div class="row g-4">
        <div class="col-md-7 animate__animated animate__fadeInLeft">
            <div class="settings-panel">
                <div class="panel-title">
                    <span><i class="fas fa-shield-alt me-2"></i>Global Ruleset</span>
                </div>
                <div class="panel-body">
                    <div class="row g-4">
                        <div class="col-md-6">
                            <label class="setting-label">Quiz Duration</label>
                            <div class="input-group">
                                <asp:TextBox ID="txtTimer" runat="server" CssClass="form-control modern-input" TextMode="Number" placeholder="e.g. 30"></asp:TextBox>
                                <span class="input-group-text small">MIN</span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label class="setting-label">Passing Threshold</label>
                            <div class="input-group">
                                <asp:TextBox ID="txtPassing" runat="server" CssClass="form-control modern-input" TextMode="Number" placeholder="e.g. 40"></asp:TextBox>
                                <span class="input-group-text small">%</span>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <label class="setting-label">Negative Marking Policy</label>
                            <asp:DropDownList ID="ddlNegative" runat="server" CssClass="form-select modern-input">
                                <asp:ListItem Value="0.00">Standard (No Deductions)</asp:ListItem>
                                <asp:ListItem Value="0.25">Quarter Penalty (0.25 Marks)</asp:ListItem>
                                <asp:ListItem Value="0.33">One-Third Penalty (0.33 Marks)</asp:ListItem>
                                <asp:ListItem Value="0.50">Half Penalty (0.50 Marks)</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-12">
                            <label class="setting-label">Batch Size (Questions)</label>
                            <asp:TextBox ID="txtCount" runat="server" CssClass="form-control modern-input" TextMode="Number" placeholder="Number of MCQs per attempt"></asp:TextBox>
                        </div>
                        <div class="col-md-12 pt-2">
                            <asp:Button ID="btnUpdateSettings" runat="server" Text="Commit Changes" CssClass="btn-update w-100 shadow-sm" OnClick="btnUpdateSettings_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-5 animate__animated animate__fadeInRight">
            <div class="info-panel shadow-sm">
                <div class="info-panel-body">
                    <h5><i class="fas fa-lightbulb me-2"></i>Administration Logic</h5>
                    <ul class="info-list">
                        <li><i class="fas fa-hourglass-half"></i><b>Auto-Submission:</b> System automatically locks and submits the response when timer hits zero.</li>
                        <li><i class="fas fa-certificate"></i><b>Dynamic Certification:</b> The passing threshold directly impacts 'Pass/Fail' badge generation.</li>
                        <li><i class="fas fa-chart-line"></i><b>Accuracy Tracking:</b> Negative marking values help in precise student percentile calculation.</li>
                        <li><i class="fas fa-random"></i><b>Question Fetch:</b> Session count picks random questions from your Intelligence Hub.</li>
                    </ul>
                    <div class="mt-5 p-4 rounded-4 bg-white border border-blue-100 text-center shadow-sm">
                         <i class="fas fa-database fa-3x text-blue-200 mb-3"></i>
                         <p class="small text-muted fw-bold mb-0 italic">Settings are applied instantly to all live student sessions.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>