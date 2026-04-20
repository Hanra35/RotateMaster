import UIKit

// API privée SpringBoard — force la rotation sur TOUT le système
@_silgen_name("SBSSetSystemForcedOrientationLock")
func SBSSetSystemForcedOrientationLock(_ o: Int32)

// 0=auto 1=portrait 2=portrait inversé 3=paysage gauche 4=paysage droit
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red:0.06, green:0.06, blue:0.12, alpha:1)
        buildUI()
    }

    private func buildUI() {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scroll)
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        let vstack = UIStackView()
        vstack.axis = .vertical
        vstack.spacing = 16
        vstack.alignment = .fill
        vstack.translatesAutoresizingMaskIntoConstraints = false
        scroll.addSubview(vstack)
        NSLayoutConstraint.activate([
            vstack.topAnchor.constraint(equalTo: scroll.topAnchor, constant: 40),
            vstack.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 20),
            vstack.trailingAnchor.constraint(equalTo: scroll.trailingAnchor, constant: -20),
            vstack.bottomAnchor.constraint(equalTo: scroll.bottomAnchor, constant: -40),
            vstack.widthAnchor.constraint(equalTo: scroll.widthAnchor, constant: -40),
        ])

        // Titre
        let title = lbl("🔄  RotateMaster", 26, .bold, .white)
        let sub   = lbl("Force la rotation partout\n(écran accueil + toutes les apps)", 13, .regular,
                         UIColor(white:1, alpha:0.4))
        sub.numberOfLines = 0
        vstack.addArrangedSubview(title)
        vstack.addArrangedSubview(sub)
        vstack.setCustomSpacing(30, after: sub)

        // Section info
        let info = infoCard("⚡ La rotation s'applique immédiatement à tout le système iOS — écran d'accueil, apps, partout. Quitte l'app après avoir sélectionné l'orientation.")
        vstack.addArrangedSubview(info)
        vstack.setCustomSpacing(28, after: info)

        // Titre section
        vstack.addArrangedSubview(sectionLbl("CHOISIR L'ORIENTATION"))

        // Boutons 2×2
        let row1 = row([
            rotBtn("⬆️", "Portrait\nnormal",    1),
            rotBtn("⬇️", "Portrait\ninversé",   2),
        ])
        let row2 = row([
            rotBtn("◀️", "Paysage\ngauche",     3),
            rotBtn("▶️", "Paysage\ndroite",     4),
        ])
        vstack.addArrangedSubview(row1)
        vstack.addArrangedSubview(row2)
        vstack.setCustomSpacing(12, after: row2)

        // Bouton auto
        let autoBtn = makeBtn("🔄   Rotation automatique (défaut)", bg: UIColor(white:1, alpha:0.07),
                               fg: UIColor(white:1, alpha:0.55), tag: 0)
        vstack.addArrangedSubview(autoBtn)
        vstack.setCustomSpacing(30, after: autoBtn)

        // Statut
        let statusTitle = sectionLbl("ORIENTATION ACTUELLE")
        vstack.addArrangedSubview(statusTitle)

        let statusCard = UIView()
        statusCard.backgroundColor = UIColor(white:1, alpha:0.05)
        statusCard.layer.cornerRadius = 12
        statusCard.heightAnchor.constraint(equalToConstant: 60).isActive = true
        vstack.addArrangedSubview(statusCard)

        let statusLbl = UILabel()
        statusLbl.text = "⬆️  Portrait normal (par défaut)"
        statusLbl.font = .systemFont(ofSize: 15, weight: .semibold)
        statusLbl.textColor = .white
        statusLbl.textAlignment = .center
        statusLbl.tag = 999
        statusLbl.translatesAutoresizingMaskIntoConstraints = false
        statusCard.addSubview(statusLbl)
        NSLayoutConstraint.activate([
            statusLbl.centerXAnchor.constraint(equalTo: statusCard.centerXAnchor),
            statusLbl.centerYAnchor.constraint(equalTo: statusCard.centerYAnchor),
        ])
    }

    // MARK: - Actions

    @objc private func rotate(_ btn: UIButton) {
        let ori = Int32(btn.tag)
        applyRotation(ori)
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()

        // Met à jour le label de statut
        let names: [Int32: String] = [
            0: "🔄  Auto",
            1: "⬆️  Portrait normal",
            2: "⬇️  Portrait inversé",
            3: "◀️  Paysage gauche",
            4: "▶️  Paysage droit",
        ]
        if let lbl = view.viewWithTag(999) as? UILabel {
            lbl.text = names[ori] ?? "?"
        }

        // Flash sur le bouton
        UIView.animate(withDuration: 0.1, animations: { btn.alpha = 0.3 }) { _ in
            UIView.animate(withDuration: 0.2) { btn.alpha = 1 }
        }
    }

    private func applyRotation(_ ori: Int32) {
        // ── Méthode principale : API SpringBoard (affecte tout le système) ──
        SBSSetSystemForcedOrientationLock(ori)

        // ── Fallback : UIDevice (affecte au moins cette app) ──
        let deviceOri: UIDeviceOrientation = {
            switch ori {
            case 1: return .portrait
            case 2: return .portraitUpsideDown
            case 3: return .landscapeRight   // inversé intentionnellement
            case 4: return .landscapeLeft
            default: return .unknown
            }
        }()
        UIDevice.current.setValue(deviceOri.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { .all }
    override var shouldAutorotate: Bool { true }

    // MARK: - Helpers UI
    private let purple = UIColor(red:0.42, green:0.27, blue:0.98, alpha:1)

    private func lbl(_ t: String,_ sz: CGFloat,_ w: UIFont.Weight,_ c: UIColor) -> UILabel {
        let l = UILabel(); l.text = t
        l.font = .systemFont(ofSize: sz, weight: w)
        l.textColor = c; l.textAlignment = .center; return l
    }

    private func sectionLbl(_ t: String) -> UILabel {
        let l = UILabel(); l.text = t
        l.font = .systemFont(ofSize: 10, weight: .semibold)
        l.textColor = UIColor(white:1, alpha:0.3)
        l.textAlignment = .left; l.letterSpacing(1.4); return l
    }

    private func infoCard(_ text: String) -> UIView {
        let card = UIView()
        card.backgroundColor = UIColor(red:0.1, green:0.35, blue:0.2, alpha:0.35)
        card.layer.cornerRadius = 12
        card.layer.borderWidth = 1
        card.layer.borderColor = UIColor(red:0.2, green:0.8, blue:0.4, alpha:0.3).cgColor
        let l = UILabel(); l.text = text
        l.font = .systemFont(ofSize: 12); l.textColor = UIColor(red:0.5,green:1,blue:0.6,alpha:0.9)
        l.numberOfLines = 0; l.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(l)
        NSLayoutConstraint.activate([
            l.topAnchor.constraint(equalTo: card.topAnchor, constant: 12),
            l.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 14),
            l.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -14),
            l.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -12),
        ])
        return card
    }

    private func rotBtn(_ emoji: String,_ text: String,_ tag: Int) -> UIButton {
        let b = UIButton(type: .system)
        b.setTitle("\(emoji)\n\(text)", for: .normal)
        b.titleLabel?.numberOfLines = 0
        b.titleLabel?.textAlignment  = .center
        b.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
        b.backgroundColor  = purple
        b.setTitleColor(.white, for: .normal)
        b.layer.cornerRadius = 14
        b.heightAnchor.constraint(equalToConstant: 80).isActive = true
        b.tag = tag
        b.addTarget(self, action: #selector(rotate(_:)), for: .touchUpInside)
        return b
    }

    private func makeBtn(_ title: String, bg: UIColor, fg: UIColor, tag: Int) -> UIButton {
        let b = UIButton(type: .system)
        b.setTitle(title, for: .normal)
        b.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        b.backgroundColor  = bg
        b.setTitleColor(fg, for: .normal)
        b.layer.cornerRadius = 13
        b.layer.borderWidth = 1
        b.layer.borderColor = UIColor(white:1,alpha:0.1).cgColor
        b.heightAnchor.constraint(equalToConstant: 50).isActive = true
        b.tag = tag
        b.addTarget(self, action: #selector(rotate(_:)), for: .touchUpInside)
        return b
    }

    private func row(_ btns: [UIView]) -> UIStackView {
        let s = UIStackView(arrangedSubviews: btns)
        s.axis = .horizontal; s.spacing = 12; s.distribution = .fillEqually; return s
    }
}

extension UILabel {
    func letterSpacing(_ s: CGFloat) {
        guard let t = text else { return }
        attributedText = NSAttributedString(string: t, attributes: [
            .kern: s, .foregroundColor: textColor ?? .white, .font: font!
        ])
    }
}
