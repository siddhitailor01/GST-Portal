<%@ Page Title="Change Password | Admin" Language="C#" MasterPageFile="~/admin/adminMasterPage.master" AutoEventWireup="true" CodeFile="ChangePassword.aspx.cs" Inherits="admin_ChangePassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        :root { --brand-primary: #6366f1; --brand-secondary: #a855f7; }
        
        .security-card { 
            border: none; border-radius: 35px; background: white; 
            box-shadow: 0 40px 80px rgba(15, 23, 42, 0.08); 
            border: 1px solid rgba(0,0,0,0.02);
            overflow: hidden;
        }
        
        .security-header {
            background: linear-gradient(135deg, #0f172a 0%, #1e1b4b 100%);
            padding: 40px; text-align: center; color: white;
        }

        .shield-icon {
            width: 70px; height: 70px; background: rgba(255,255,255,0.1);
            border-radius: 20px; display: flex; align-items: center; 
            justify-content: center; margin: 0 auto 20px; font-size: 2rem;
            border: 1px solid rgba(255,255,255,0.2);
            color: var(--brand-secondary);
        }

        .form-label { font-weight: 800; color: #475569; font-size: 0.75rem; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 10px; }
        
        .input-group-modern {
            background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 16px;
            padding: 5px 15px; display: flex; align-items: center; transition: 0.3s;
        }
        
        .input-group-modern:focus-within { 
            border-color: var(--brand-primary); background: white; 
            box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.1); 
        }

        .input-group-modern i { color: #94a3b8; margin-right: 15px; font-size: 1.1rem; }
        
        .form-control-modern { 
            border: none; background: transparent; padding: 12px 0; 
            font-weight: 700; color: #1e293b; width: 100%;
        }
        .form-control-modern:focus { outline: none; }

        .btn-update {
            background: linear-gradient(135deg, var(--brand-primary), var(--brand-secondary));
            border: none; border-radius: 16px; padding: 16px;
            color: white !important; font-weight: 900; text-transform: uppercase;
            letter-spacing: 1px; transition: 0.4s; margin-top: 10px;
        }
        .btn-update:hover { transform: translateY(-3px); box-shadow: 0 15px 30px rgba(168, 85, 247, 0.3); }

        .security-tip { background: #f1f5f9; border-radius: 15px; padding: 20px; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-6">
                <div class="security-card animate__animated animate__fadeInUp">
                    <div class="security-header">
                        <div class="shield-icon shadow">
                            <i class="fas fa-user-shield"></i>
                        </div>
                        <h3 class="fw-900 mb-1">Account Security</h3>
                        <p class="opacity-50 small mb-0 uppercase tracking-widest">Update Admin Credentials</p>
                    </div>

                    <div class="card-body p-5">
                        <div class="mb-4">
                            <label class="form-label">Current Password</label>
                            <div class="input-group-modern">
                                <i class="fas fa-lock-open"></i>
                                <asp:TextBox ID="txtOldPass" runat="server" CssClass="form-control-modern" TextMode="Password" placeholder="Old Password"></asp:TextBox>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label">Create New Password</label>
                            <div class="input-group-modern">
                                <i class="fas fa-key"></i>
                                <asp:TextBox ID="txtNewPass" runat="server" CssClass="form-control-modern" TextMode="Password" placeholder="New Password"></asp:TextBox>
                            </div>
                        </div>

                        <div class="mb-5">
                            <label class="form-label">Confirm New Password</label>
                            <div class="input-group-modern">
                                <i class="fas fa-shield-check"></i>
                                <asp:TextBox ID="txtConfirmPass" runat="server" CssClass="form-control-modern" TextMode="Password" placeholder="Repeat New Password"></asp:TextBox>
                            </div>
                        </div>

                        <asp:Button ID="btnUpdatePass" runat="server" Text="Save Security Changes" 
                            CssClass="btn btn-update w-100 shadow-lg" OnClick="btnUpdatePass_Click" />
                        
                        <div class="security-tip mt-5 border">
                            <h6 class="fw-900 text-dark small mb-2"><i class="fas fa-lightbulb me-2 text-warning"></i>Champion Advice:</h6>
                            <p class="small text-muted mb-0">Password kam se kam 8 characters ka rakhein aur usme numbers aur symbols use karein. Accuracy priority hai, par Account Security hamesha champion level ki honi chahiye!</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>