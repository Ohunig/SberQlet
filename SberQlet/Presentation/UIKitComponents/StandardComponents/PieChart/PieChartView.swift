//
//  PieChartView.swift
//  SberQlet
//
//  Created by User on 24.12.2025.
//

import Foundation
import UIKit

final class PieChartView: UIView {

    // Участки диаграммы
    var slices: [PieSlice] = [] {
        didSet {
            drawChart()
        }
    }

    private func drawChart() {
        layer.sublayers?.forEach { $0.removeFromSuperlayer() }

        let total = slices.reduce(0) { $0 + $1.value }
        var startAngle: CGFloat = -.pi / 2 // начинаем сверху
        let centerPoint = CGPoint(
            x: bounds.midX,
            y: bounds.midY
        )
        
        // Предотвращаем возможное деление на 0
        guard total != 0 else {
            return
        }

        for slice in slices {
            let endAngle = startAngle + 2 * .pi * (slice.value / total)

            let path = UIBezierPath()
            path.move(to: centerPoint)
            path.addArc(
                withCenter: centerPoint,
                radius: min(bounds.width, bounds.height) / 2,
                startAngle: startAngle,
                endAngle: endAngle,
                clockwise: true
            )
            path.close()

            let layer = CAShapeLayer()
            layer.path = path.cgPath
            layer.fillColor = slice.color.cgColor

            self.layer.addSublayer(layer)
            startAngle = endAngle
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        drawChart()
    }
}
