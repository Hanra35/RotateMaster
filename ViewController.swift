import UIKit
import Darwin  // donne accès à dlopen, dlsym, dlclose

// ═══════════════════════════════════════════════════════════
//  Rotation SYSTÈME via SpringBoardServices (chargement dynamique)
//
//  @_silgen_name provoque une erreur de linker car le symbole
//  n'est pas dans le SDK public. On utilise dlopen/dlsym à la
//  place : le framework est chargé en mémoire AU MOMENT
//  de l'exécution → zéro erreur de compilation/linker.
//
//  Valeurs :
//    0 = auto (déverrouillé)
//    1 = Portrait
//    2 = Portrait inversé
//    3 = Paysage gauche
//    4 = Paysage droit
// ═══════════════════════════════════════════════════════════

func forceSystemRotation(_ value: Int32) {
    // Chemin du framework privé SpringBoardServices
    let path = "/System/Library/PrivateFrameworks/SpringBoardServices.framework/SpringBoardServices"

    // Ouvre le framework dynamiquement
    guard let handle = dlopen(path, RTLD_NOW) else {
        print("[RotateMaster] dlopen échoué: \(String(cString: dlerror()))")
        return
    }
    defer { dlclose(handle) }

    // Cherche le symbole SBSSetSystemForcedOrientationLock
    guard let sym = dlsym(handle, "SBSSetSystemForcedOrientationLock") else {
        print("[RotateMaster] Symbole introuvable")
        return
    }

    // Cast le pointeur en fonction C typée
    typealias LockFunc = @convention(c) (Int32) -> Void
    let lockFn = unsafeBitCast(sym, to: LockFunc.self)

    // Appelle la fonction — affecte TOUT le système iOS
    lockFn(value)
    print("[RotateMaster] Rotation système appliquée: \(value)")
}

// ═══════════════════════════════════════════════════════════
//  Interface
// ═══════════════════════════════════════════════════════════

class ViewController: UIViewController {

    // Label de statut mis à jour après chaque appui
    private let statusLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.10, alpha: 1)
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

        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 14
        stack.translatesAutoresizingMaskIntoConstraints = false
        scroll.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: scroll.topAnchor, constant: 36),
            stack.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: scroll.trailingAnchor, constant: -20),
            stack.bottomAnchor.constraint(equalTo: scroll.bottomAnchor, constant: -36),
            stack.widthAnchor.constraint(equalTo: scroll.widthAnchor, constant: -40),
        ])

        // ── Titre ──
        stack.addArrangedSubview(makeLabel("🔄  RotateMaster", 26, .bold, .white))
        stack.addArrangedSubview(makeLabel(
            "Force la rotation sur tout iOS\n(écran accueil + toutes les apps)",
            13, .regular, UIColor(white: 1, alpha: 0.4)))
        stack.setCustomSpacing(24, after: stack.arrangedSubviews.last!)

        // ── Info ──
        let info = infoCard(
            "⚡  Appuie sur une orientation → elle s'applique immédiatement partout.\n" +
            "Quitte l'app après avoir choisi."
        )
        stack.addArrangedSubview(info)
        stack.setCustomSpacing(26, after: info)

        // ── Titre section ──
        stack.addArrangedSubview(sectionLabel("CHOISIR L'ORIENTATION"))

        // ── Boutons 2×2 ──
        let row1 = hRow([
            rotBtn("⬆️", "Portrait\nnormal",   1),
            rotBtn("⬇️", "Portrait\ninversé",  2),
        ])
        let row2 = hRow([
            rotBtn("◀️", "Paysage\ngauche",    3),
            rotBtn("▶️", "Paysage\ndroite",    4),
        ])
        stack.addArrangedSubview(row1)
        stack.addArrangedSubview(row2)
        stack.setCustomSpacing(10, after: row2)

        // ── Bouton Auto ──
        let autoBtn = actionBtn("🔄   Rotation automatique (défaut)", tag: 0)
        stack.addArrangedSubview(autoBtn)
        stack.setCustomSpacing(24, after: autoBtn)

        // ── Statut ──
        stack.addArrangedSubview(sectionLabel("STATUT"))

        let card = UIView()
        card.backgroundColor = UIColor(white: 1, alpha: 0.05)
        card.layer.cornerRadius = 12
        card.heightAnchor.constraint(equalToConstant: 54).isActive = true
        stack.addArrangedSubview(card)

        statusLabel.text = "Aucune rotation forcée"
        statusLabel.font = .systemFont(ofSize: 14, weight: .medium)
        statusLabel.textColor = UIColor(white: 1, alpha: 0.55)
        statusLabel.textAlignment = .center
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(statusLabel)
        NSLayoutConstraint.activate([
            statusLabel.centerXAnchor.constraint(equalTo: card.centerXAnchor),
            statusLabel.centerYAnchor.constraint(equalTo: card.centerYAnchor),
        ])
    }

    // MARK: - Action principale

    @objc private func onRotate(_ btn: UIButton) {
        let v = Int32(btn.tag)

        // ── 1. Appel SpringBoardServices (affecte tout le système) ──
        forceSystemRotation(v)

        // ── 2. Fallback UIDevice (au moins cette app) ──
        let deviceOri: UIDeviceOrientation = {
            switch v {
            case 1: return .portrait
            case 2: return .portraitUpsideDown
            case 3: return .landscapeRight
            case 4: return .landscapeLeft
            default: return .unknown
            }
        }()
        UIDevice.current.setValue(deviceOri.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()

        // ── 3. Mise à jour UI ──
        let names: [Int32: String] = [
            0: "🔄  Auto",
            1: "⬆️  Portrait normal",
            2: "⬇️  Portrait inversé",
            3: "◀️  Paysage gauche",
            4: "▶️  Paysage droit",
        ]
        statusLabel.text = names[v] ?? "?"
        statusLabel.textColor = v == 0
            ? UIColor(white: 1, alpha: 0.55)
            : UIColor(red: 0.4, green: 1.0, blue: 0.6, alpha: 1)

        // Flash bouton
        UIView.animate(withDuration: 0.08, animations: { btn.alpha = 0.3 }) { _ in
            UIView.animate(withDuration: 0.18) { btn.alpha = 1 }
        }
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { .all }
    override var shouldAutorotate: Bool { true }

    // MARK: - Helpers UI

    private let purple = UIColor(red: 0.42, green: 0.27, blue: 0.98, alpha: 1)

    private func makeLabel(_ t: String, _ sz: CGFloat, _ w: UIFont.Weight, _ c: UIColor) -> UILabel {
        let l = UILabel()
        l.text = t
        l.font = .systemFont(ofSize: sz, weight: w)
        l.textColor = c
        l.textAlignment = .center
        l.numberOfLines = 0
        return l
    }

    private func sectionLabel(_ t: String) -> UILabel {
        let l = UILabel()
        l.text = t
        l.font = .systemFont(ofSize: 10, weight: .semibold)
        l.textColor = UIColor(white: 1, alpha: 0.28)
        l.textAlignment = .left
        return l
    }

    private func infoCard(_ text: String) -> UIView {
        let card = UIView()
        card.backgroundColor = UIColor(red: 0.08, green: 0.30, blue: 0.16, alpha: 0.5)
        card.layer.cornerRadius = 12
        card.layer.borderWidth = 1
        card.layer.borderColor = UIColor(red: 0.2, green: 0.75, blue: 0.35, alpha: 0.35).cgColor
        let l = UILabel()
        l.text = text
        l.font = .systemFont(ofSize: 12)
        l.textColor = UIColor(red: 0.5, green: 1, blue: 0.65, alpha: 0.9)
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(l)
        NSLayoutConstraint.activate([
            l.topAnchor.constraint(equalTo: card.topAnchor, constant: 12),
            l.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 14),
            l.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -14),
            l.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -12),
        ])
        return card
    }

    private func rotBtn(_ emoji: String, _ label: String, _ tag: Int) -> UIButton {
        let b = UIButton(type: .system)
        b.setTitle("\(emoji)\n\(label)", for: .normal)
        b.titleLabel?.numberOfLines = 0
        b.titleLabel?.textAlignment = .center
        b.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
        b.backgroundColor = purple
        b.setTitleColor(.white, for: .normal)
        b.layer.cornerRadius = 14
        b.heightAnchor.constraint(equalToConstant: 80).isActive = true
        b.tag = tag
        b.addTarget(self, action: #selector(onRotate(_:)), for: .touchUpInside)
        return b
    }

    private func actionBtn(_ title: String, tag: Int) -> UIButton {
        let b = UIButton(type: .system)
        b.setTitle(title, for: .normal)
        b.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        b.backgroundColor = UIColor(white: 1, alpha: 0.07)
        b.setTitleColor(UIColor(white: 1, alpha: 0.6), for: .normal)
        b.layer.cornerRadius = 13
        b.layer.borderWidth = 1
        b.layer.borderColor = UIColor(white: 1, alpha: 0.1).cgColor
        b.heightAnchor.constraint(equalToConstant: 50).isActive = true
        b.tag = tag
        b.addTarget(self, action: #selector(onRotate(_:)), for: .touchUpInside)
        return b
    }

    private func hRow(_ views: [UIView]) -> UIStackView {
        let s = UIStackView(arrangedSubviews: views)
        s.axis = .horizontal
        s.spacing = 12
        s.distribution = .fillEqually
        return s
    }
}
