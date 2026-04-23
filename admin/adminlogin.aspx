<%@ Page Language="C#" AutoEventWireup="true" CodeFile="adminlogin.aspx.cs" Inherits="admin_adminlogin" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Secure Login | GST Champions</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;800&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --brand-primary: #6366f1;
            --brand-secondary: #a855f7;
            --brand-dark: #0f172a;
        }

        body { 
            background: linear-gradient(135deg, #0f172a 0%, #1e1b4b 100%);
            font-family: 'Plus Jakarta Sans', sans-serif; 
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
            overflow: hidden;
        }

        /* --- Animated Background Shapes --- */
        .shape { position: absolute; filter: blur(80px); z-index: -1; border-radius: 50%; opacity: 0.4; }
        .shape-1 { width: 400px; height: 400px; background: var(--brand-primary); top: -10%; left: -10%; }
        .shape-2 { width: 300px; height: 300px; background: var(--brand-secondary); bottom: -5%; right: -5%; }

        .login-card {
            width: 100%;
            max-width: 450px;
            background: rgba(255, 255, 255, 0.03);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 40px;
            padding: 50px 40px;
            box-shadow: 0 40px 100px rgba(0,0,0,0.4);
            animation: fadeIn 0.8s ease-out;
        }

        @keyframes fadeIn { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }

        .login-header { text-align: center; margin-bottom: 40px; }
        
        .brand-logo {
            width: 70px; height: 70px;
            background: linear-gradient(135deg, var(--brand-primary), var(--brand-secondary));
            border-radius: 20px;
            display: flex; align-items: center; justify-content: center;
            margin: 0 auto 20px;
            font-size: 2rem; color: white;
            box-shadow: 0 15px 30px rgba(99, 102, 241, 0.3);
        }

        .header-title { color: white; font-weight: 800; letter-spacing: -1px; margin-bottom: 5px; }
        .header-subtitle { color: #94a3b8; font-size: 0.9rem; font-weight: 600; }

        /* --- Input Styling --- */
        .form-label { color: #cbd5e1; font-weight: 700; font-size: 0.75rem; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 10px; }
        
        .input-group {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 18px;
            overflow: hidden;
            transition: 0.3s;
        }
        
        .input-group:focus-within { border-color: var(--brand-primary); background: rgba(255, 255, 255, 0.08); }

        .input-group-text { background: transparent; border: none; color: #64748b; padding-left: 20px; }
        
        .form-control { 
            background: transparent; border: none; color: white !important; 
            padding: 15px 20px; font-weight: 600; 
        }
        .form-control::placeholder { color: #475569; }
        .form-control:focus { background: transparent; box-shadow: none; }

        /* --- Button Styling --- */
        .btn-login {
            background: linear-gradient(135deg, var(--brand-primary), var(--brand-secondary));
            border: none; border-radius: 18px; padding: 16px;
            color: white; font-weight: 800; text-transform: uppercase;
            letter-spacing: 1px; transition: 0.4s; margin-top: 20px;
        }
        .btn-login:hover { transform: translateY(-5px); box-shadow: 0 15px 30px rgba(168, 85, 247, 0.4); color: white; }

        .back-link { color: #64748b; text-decoration: none; font-weight: 700; font-size: 0.85rem; transition: 0.3s; display: block; margin-top: 30px; text-align: center; }
        .back-link:hover { color: white; }

        .error-panel { border-radius: 15px; background: rgba(244, 63, 94, 0.1); border: 1px solid rgba(244, 63, 94, 0.2); color: #fb7185; }
    </style>
</head>
<body>
    <div class="shape shape-1"></div>
    <div class="shape shape-2"></div>

    <form id="form1" runat="server">
        <div class="login-card">
            <div class="login-header">
                <div class="brand-logo shadow">
                    <i class="fas fa-shield-halved"></i>
                </div>
                <h3 class="header-title">GST CHAMPIONS</h3>
                <p class="header-subtitle">Administrative Control Access</p>
            </div>

            <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="alert error-panel py-3 small mb-4">
                <i class="fas fa-circle-exclamation me-2"></i> Username or password is incorrect.
            </asp:Panel>

            <div class="mb-4">
                <label class="form-label">Admin Username</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-user-shield"></i></span>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Enter username"></asp:TextBox>
                </div>
            </div>

            <div class="mb-5">
                <label class="form-label">Secret Password</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-key"></i></span>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="••••••••"></asp:TextBox>
                </div>
            </div>

            <asp:Button ID="btnLogin" runat="server" Text="Unlock Dashboard" CssClass="btn w-100 btn-login" OnClick="btnLogin_Click" />

            <a href="../Default.aspx" class="back-link">
                <i class="fas fa-arrow-left-long me-2"></i> Return to Main Website
            </a>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>