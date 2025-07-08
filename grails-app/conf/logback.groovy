import grails.util.BuildSettings
import grails.util.Environment
import org.springframework.boot.logging.logback.ColorConverter
import org.springframework.boot.logging.logback.WhitespaceThrowableProxyConverter

import java.nio.charset.Charset

conversionRule 'clr', ColorConverter
conversionRule 'wex', WhitespaceThrowableProxyConverter

// See http://logback.qos.ch/manual/groovy.html for details on configuration
appender('STDOUT', ConsoleAppender) {
    encoder(PatternLayoutEncoder) {
        charset = Charset.forName('UTF-8')

        pattern =
                '%clr(%d{yyyy-MM-dd HH:mm:ss.SSS}){faint} ' + // Date
                        '%clr(%5p) ' + // Log level
                        '%clr(---){faint} %clr([%15.15t]){faint} ' + // Thread
                        '%clr(%-40.40logger{39}){cyan} %clr(:){faint} ' + // Logger
                        '%m%n%wex' // Message
    }
}

def targetDir = BuildSettings.TARGET_DIR
if (Environment.isDevelopmentMode() && targetDir != null) {
    appender("FULL_STACKTRACE", FileAppender) {
        file = "${targetDir}/stacktrace.log"
        append = true
        encoder(PatternLayoutEncoder) {
            pattern = "%level %logger - %msg%n"
        }
    }
    logger("StackTrace", ERROR, ['FULL_STACKTRACE'], false)
}

// Add SQL and Hibernate logging for development
if (Environment.isDevelopmentMode()) {
    logger("org.hibernate.SQL", DEBUG, ['STDOUT'], false)
    logger("org.hibernate.type.descriptor.sql.BasicBinder", TRACE, ['STDOUT'], false)
    logger("org.springframework.boot.autoconfigure", DEBUG, ['STDOUT'], false)
    logger("org.hibernate.tool.hbm2ddl", DEBUG, ['STDOUT'], false)
    logger("org.hibernate.cfg", DEBUG, ['STDOUT'], false)
    logger("grails.gorm", DEBUG, ['STDOUT'], false)
    logger("org.grails.orm.hibernate", DEBUG, ['STDOUT'], false)
    logger("org.grails.core.artefact", DEBUG, ['STDOUT'], false)
    logger("grails.core.DefaultGrailsApplication", DEBUG, ['STDOUT'], false)
}

root(INFO, ['STDOUT'])
